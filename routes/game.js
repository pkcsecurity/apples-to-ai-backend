const express = require("express");
const router = express.Router();
const uuid = require("uuid/v4");
const dynamo = require("../dynamodb");
const s3 = require("../aws/s3");
const rekognition = require("../aws/rekognition");

/*
 * This is the /game router!
 */

// GET home page
router.get("/", (req, res) => {
  res.send(
    "Hello world! Ready to throw some apples at an AI to see what sticks?"
  );
});

/* POST init a new game
 * Expects a JSON body like:
 * {
 *   gameName: "",
 *   ownerEmail: "",
 *   maxScore: 0
 * }
 * Responds with the following body:
 * { token: "" }
 */
router.post("/", (req, res) => {
  const game = dynamo.getGameState(req.gameName);
  if (game) {
    res.status(400).send("Game with that name already exists")
  }
  const token = uuid();
  dynamo.initNewGame(req.gameName, token, req.ownerEmail, req.maxScore);
  res.send({ token: token });
});

/* POST a new player enters a game
 * Expects a JSON body like:
 * {
 *   email: ""
 * }
 * Responds with the following body:
 * { token: "" }
 */
router.post("/:gameName/player", async (req, res) => {
  const gameName = req.params.gameName;
  const game = await dynamo.getGameState(gameName);
  if (!game) {
    res.status(404).send("No game of that name.")
  }
  const token = uuid();
  await dynamo.addPlayerToGame(gameName, token, req.email);
  res.send({ token: token });
});

// GET game state
router.get("/:gameName", async (req, res) => {
  const game = await dynamo.getGameState(req.params.gameName);
  if (game) {
    res.send(game.GameState);
  } else {
    res.status(404).end();
  }
});

/* POST round leader sets the word for the round
 * Expects a JSON body like:
 * {
 *   word: "door"
 * }
 * Responds with 200
 */
router.post("/:gameName/word", async (req, res) => {
  const gameName = req.params.gameName;
  const game = await dynamo.getGameState(gameName);
  if (!game) {
    res.status(404).send("No game of that name.")
  }
  await dynamo.addRoundLeaderWord(gameName, req.token, req.word);
  res.end();
});

 // POST player uploads their image submission for the round
 // * Expects a JSON body like:
 // * {
 // *   fileName: "image.jpg"
 // *   file: <image object>
 // * }
 // * Responds with 200
router.post("/:gameName/submission", async (req, res) => {
  const fileName = req.body.fileName;
  const fileExt = fileName.slice((fileName.lastIndexOf(".") - 1 >>> 0) + 2);
  if(fileExt !== "jpg" || fileExt !== "png"){
    res.status(400).send("Please submit image in jpg or png format.");
  }

  // Upload image to s3
  const gameName = req.params.gameName;
  const token = req.token;
  const bucketName = "applestoai/" + gameName;
  const img = req.body.file;
  const imgName = Date.now() + token + "." + fileExt;
  const s3Res = await s3.uploadImage(bucketName, imgName, img);

  // Send s3 URL to rekog
  const rekogRes = await rekognition.getLabels(bucketName, imgName);

  // Parse rekRes into vetcor of labels
  const rekogData = rekRes.Labels.map(function(item){
    return item.Name;
  });
  await dynamo.addPlayerImageSubmission(gameName, token, bucketName + "/" + imgName, rekogData);
  res.end();
});

// POST round leader chooses the winning submission
router.post("/:gameName/choice", async (req, res) => {
  const gameName = req.params.gameName;
  const game = await dynamo.getGameState(gameName);
  if (!game) {
    res.status(404).send("No game of that name.")
  }
  await dynamo.addRoundLeaderChoice(gameName, req.token, req.word);
  res.end();
});

module.exports = router;
