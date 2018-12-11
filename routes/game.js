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
  await dynamo.addRoundLeaderWord(gameName, req.word);
  res.end();
});

// POST player uploads their image submission for the round
router.post("/:gameName/submission", (req, res) => {
  // Upload image to s3
  const gameName = req.params.gameName;
  const token = req.token;
  const bucketName = "applestoai/" + gameName;
  const imgName = Date.now() + token + ".jpg";
  const img = req.body.img;
  const s3Res = s3.uploadImage(bucketName, imgName, img);
  if(s3Res.statuCode != 200){
    res.status(400).send("Image submission failed.");
  }

  const rekData = rekognition.getLabels(bucketName, imgName);
  if(!rekData.Labels){
    res.status(400).send("Image or bucket not accessible.")
  }
  // Send s3 URL to rekog
  dynamo.addPlayerImageSubmission(gameName, token, imgUrl, rekogData);
});

// POST round leader chooses the winning submission
router.post("/:gameName/choice");

module.exports = router;
