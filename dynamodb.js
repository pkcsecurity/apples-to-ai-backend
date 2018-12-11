const aws = require("aws-sdk");
aws.config.update({ region: "us-west-2" });
const dc = new aws.DynamoDB.DocumentClient({ apiVersion: "2012-08-10" });

exports.initNewGame = (name, ownerToken, ownerEmail, maxScore) => {
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
      GameState: []
    }
  };

  dc.put(params, (err, data) => {
    if (err) console.error(err);
    else console.log(data);
  });
};

exports.getGameState = gameName => {
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

exports.addPlayerToGame = (gameName, token, email) => {


}
