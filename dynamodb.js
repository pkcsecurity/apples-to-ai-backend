const aws = require("aws-sdk");
aws.config.update({ region: "us-west-2" });
const dc = new aws.DynamoDB.DocumentClient({ apiVersion: "2012-08-10" });

const initNewGame = async (name, ownerToken, ownerEmail, maxScore) => {
  const game = {
    GameName: name,
    GameOwner: ownerToken,
    Players: [{ email: ownerEmail, token: ownerToken, score: 0 }],
    MaxScore: maxScore,
    WinningPlayerIndex: -1,
    StartDateTime: Date.now(),
    GameState: [
      getBlankGameRound(0)
    ]
  };

  await saveGame(game);
};

const saveGame = async (game) => {
  const params = {
    TableName: "apples-to-ai",
    Item: game
  };
  return await dc.put(params).promise();
}


const getBlankGameRound = (leaderIndex) => {
  return {
    leaderIndex,
    objectWord: null,
    step: 0,
    submissions: []
  }
}

const getGameState = async gameName => {
  const params = {
    TableName: "apples-to-ai",
    Key: { GameName: gameName }
  };

  try {
    const resp = await dc.get(params).promise();
    const game = resp.Item;
    return game;
  } catch (err) {
    console.log(err);
    return null;
  }
};

const addPlayerToGame = async (gameName, token, email) => {
  const game = await getGameState(gameName);
  game.Players.push({ email, token, score: 0 });
  await saveGame(game);
}

const addPlayerImageSubmission = async (gameName, token, imgUrl, rekogData) => {
  const game = await getGameState(gameName);
  const currentGameState = game.GameState[game.GameState.length - 1];
  if (!(getPlayerIndexByToken(game, token) !== currentGameState.leaderIndex &&
    currentGameState.step === 1)) {
    throw "You are the round leader or this round is not in image submissions step"
  }
  const imgSub = getSubmission(game, token, imgUrl, rekogData);
  currentGameState.submissions.push(imgSub);
  // If final image submission, update game step
  if (currentGameState.submissions.length >= (game.Players.length - 1)) {
    currentGameState.step = 2;
  }
  await saveGame(game);
}

const addRoundLeaderWord = async (gameName, token, word) => {
  const game = await getGameState(gameName);
  const currentGameState = game.GameState[game.GameState.length - 1];
  if (!(getPlayerIndexByToken(game, token) === currentGameState.leaderIndex && currentGameState.step === 0)) {
    throw "You are not the round leader and cannot set the word, or the word has already been set for this round"
  }
  currentGameState.objectWord = word;
  currentGameState.step = 1;
  await saveGame(game);
}

const addRoundLeaderChoice = async (gameName, token, winningSubmissionIndex) => {
  const game = getGameState(gameName);
  const currentGameState = game.GameState[game.GameState.length - 1];

  if (!(getPlayerIndexByToken(game, token) === currentGameState.leaderIndex &&
    currentGameState.step === 2)) {
    throw "You are not the round leader or all submissions aren't yet in for this round"
  }

  currentGameState.submissions[winningSubmissionIndex].chosen = true;
  game.Players[currentGameState.submissions[winningSubmissionIndex].playerIndex].score++;

  if (game.Players[currentGameState.submissions[winningSubmissionIndex].playerIndex].score >= game.maxScore) {
    console.log(`Game over, ${game.Players[currentGameState.submissions[winningSubmissionIndex].playerIndex].email} won!`)
    game.WinningPlayerIndex = currentGameState.submissions[winningSubmissionIndex].playerIndex;
  } else {
    console.log("New round")
    const leaderIndex = (currentGameState.leaderIndex++) % game.Players.length;
    game.GameState.push(getBlankGameRound(leaderIndex))
  }
  await saveGame(game);
}

const getSubmission = (game, token, imgUrl, rekogData) => {
  const wordFoundInImage = false; // FIXME PARSE rekogData to see if 

  return {
    imgUrl,
    playerIndex: getPlayerIndexByToken(game, token),
    wordFoundInImage,
    chosen: false,
    rekogData
  }
}

const getPlayerIndexByToken = (game, token) => {
  for (let [index, value] of game.Players.entries()) {
    if (value.token === token) {
      return index;
    }
  }
  throw "Invalid token";
}


module.exports = {
  initNewGame,
  getGameState,
  addPlayerToGame,
  addPlayerImageSubmission,
  addRoundLeaderWord,
  addRoundLeaderChoice
}