const aws = require("aws-sdk");
aws.config.update({ region: "us-west-2" });
const dc = new aws.DynamoDB.DocumentClient({ apiVersion: "2012-08-10" });

exports.initNewGame = (name, ownerToken, ownerEmail, maxScore) => {
  let params = {
    TableName: "apples-to-ai",
    Item: {
      GameName: name,
      GameOwner: ownerToken,
      Players: [{ email: ownerEmail, token: ownerToken, score: 0 }],
      CurrentPlayerIndex: 0,
      MaxScore: maxScore,
      WinningPlayerIndex: null,
      StartDateTime: Date.now(),
      State: []
    }
  };

  dc.put(params, (err, data) => {
    if (err) console.error(err);
    else console.log(data);
  });
};

/*

Game: {
    name: ""
    gameOwner: token
    players: [
        {email: "nhatcher@pkcsecurity.com", token: <uuid>, score: 0}
    ]
    currentPlayerIndex: 0
    maxScore: 7
    winningPlayerIndex: null
    startDateTime

GameState: [
    {
        leaderIndex: 0,
        objectWord: "door"
        step: 1
        submissions: [
            {
                imgUrl: http....
                playerIndex: 1
                wordFoundInImage: bool
                chosen: bool
                foundInImage: { aws label response} 
            }
        ]

    }
]
}

*/
