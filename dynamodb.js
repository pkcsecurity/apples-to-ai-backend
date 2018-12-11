const aws = require("aws-sdk");
aws.config.update({ region: "us-west-2" });
const dc = new aws.DynamoDB.DocumentClient({ apiVersion: "2012-08-10" });

const initNewGame = (name, ownerToken, ownerEmail, maxScore) => {
  const params = {
    TableName: "apples-to-ai",
    Item: {
      GameName: name,
      GameOwner: ownerToken,
      Players: [{ email: ownerEmail, token: ownerToken, score: 0 }],
      CurrentPlayerIndex: 0,
      MaxScore: maxScore,
      WinningPlayerIndex: null,
      StartDateTime: Date.now(),
      GameState: [
        getBlankGameRound(0)
      ]
    }
  };

  dc.put(params, (err, data) => {
    if (err) console.error(err);
    else console.log(data);
  });
};

const getBlankGameRound = () => {
  return {
    leaderIndex: 0,
    objectWord: null,
    step: 0,
    submissions: []
  }
}



const getGameState = gameName => {
  const params = {
    TableName: "apples-to-ai",
    Key: { GameName: gameName }
  };

  dc.get(params, (err, data) => {
    if (err) {
      console.error(err);
      return null;
    } else {
      return data.Item;
    }
  });
};

const addPlayerToGame = (gameName, token, email) => {


}

const addPlayerImageSubmission = (gameName, token, imgUrl, rekogData) => {
  const game = getGameState(gameName);
  const imgSub = getSubmission(game, token, imgUrl, rekogData);
  game

}


const addRoundLeaderWord = (gameName, token, email) => {


}

const addRoundLeaderChoice = (gameName, token, email) => {


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