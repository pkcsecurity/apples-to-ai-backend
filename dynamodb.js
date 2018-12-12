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


const getBlankGameRound = () => {
  return {
    leaderIndex: 0,
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
    return resp.Item;
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

const addPlayerImageSubmission = (gameName, token, imgUrl, rekogData) => {
  const game = await getGameState(gameName);
  const imgSub = getSubmission(game, token, imgUrl, rekogData);
  game.GameState[game.GameState.length - 1].submissions.push(imgSub);
  await saveGame(game);
}

const addRoundLeaderWord = (gameName, token, word) => {
  const game = getGameState(gameName);
  const currentGameState = game.GameState[game.GameState.length - 1];
  if (getPlayerIndexByToken(token) === currentGameState.leaderIndex &&
    currentGameState.step === 0) {
    currentGameState.objectWord = word;
    currentGameState.step = 1;
    await saveGame(game);
  }
  throw "You are not the round leader and cannot set the word, or the word has already been set for this round"
}

const addRoundLeaderChoice = (gameName, token, winningSubmissionIndex) => {
  const game = getGameState(gameName);
  const currentGameState = game.GameState[game.GameState.length - 1];

  if (getPlayerIndexByToken(token) === currentGameState.leaderIndex &&
    currentGameState.step === 2) {
    currentGameState.submissions[winningSubmissionIndex].chosen = true;
    game.Players[currentGameState.submissions[winningSubmissionIndex].playerIndex].score++;

    /// TODO IMPLEMENT NEXT ROUND AND POSSIBLE WIN LOGIC

    // if person who just got point hit max, they win
    // if not, then create another round


    await saveGame(game);
  }
  throw "You are not the round leader and cannot set the word, or the word has already been set for this round"

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