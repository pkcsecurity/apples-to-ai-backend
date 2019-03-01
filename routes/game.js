const express = require("express");
const router = express.Router();
const uuid = require("uuid/v4");
const dynamo = require("../dynamodb");
const s3 = require("../aws/s3");
const rekognition = require("../aws/rekognition");
const fs = require("fs");
const path = require("path");

const multer = require("multer");
const upload = multer({ storage: multer.memoryStorage() });

const util = require("util");

/*
 * This is the /game router!
 */

// GET home page
router.get("/", (req, res) => {
  res.send(
    "Hello world! Ready to throw some apples at an AI to see what sticks?"
  );
});

// MVP Hackathon of Regrets GOOOO
// Expects a multipart/form-data request containing a single image under the key `photo`
// Returns the JSON response from Rekog as {"list": [rekogres1, rekogres2, ...]}
router.post("/rekog", upload.single("photo"), async (req, res) => {
  // Upload image to s3
  const bucketName = "applestoaisubmissions";
  const imgName = "mvp/" + Date.now() + ".jpg";

  console.log(`Got ${util.inspect(req.file)}`);

  try {
    await s3.uploadImage(bucketName, imgName, req.file.buffer);
  } catch (err) {
    console.log(err);
    res.status(400).send("Image submission failed.");
  }

  // Send s3 URL to rekog
  let rekogRes;
  try {
    rekogRes = await rekognition.getLabels(bucketName, imgName);
  } catch (err) {
    console.log(err);
    res.status(400).send("Image not accessible.");
  }

  console.log(`\nGot rekog response!\n${util.inspect(rekogRes)}\n`);
  res.json({
    list: rekogRes.Labels.map(function(item) {
      delete item.Instances;
      return item;
    })
  });
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
router.post("/", async (req, res) => {
  const game = await dynamo.getGameState(req.body.gameName);
  if (game) {
    console.log(game);
    return res.status(400).send("Game with that name already exists");
  }
  const token = uuid();
  dynamo.initNewGame(
    req.body.gameName,
    token,
    req.body.ownerEmail,
    req.body.maxScore
  );
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
    return res.status(404).send("No game of that name.");
  }
  const token = uuid();
  await dynamo.addPlayerToGame(gameName, token, req.body.email);
  res.send({ token: token });
});

// GET game state
router.get("/:gameName", async (req, res) => {
  const game = await dynamo.getGameState(req.params.gameName);
  if (game) {
    res.send(game);
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
    return res.status(404).send("No game of that name.");
  }
  try {
    await dynamo.addRoundLeaderWord(gameName, req.token, req.body.word);
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
  res.end();
});

// POST player uploads their image submission for the round
// * Expects a multipart/form-data file upload
// * Responds with 200
router.post(
  "/:gameName/submission",
  upload.single("photo"),
  async (req, res) => {
    // Upload image to s3
    const gameName = req.params.gameName;
    const token = req.token;
    const bucketName = "applestoaisubmissions";
    const imgName = gameName + "/" + Date.now() + token + ".jpg";

    try {
      await s3.uploadImage(bucketName, imgName, req.file.buffer);
    } catch (err) {
      console.log(err);
      res.status(400).send("Image submission failed.");
    }

    // Send s3 URL to rekog
    let rekogRes;
    try {
      rekogRes = await rekognition.getLabels(bucketName, imgName);
    } catch (err) {
      console.log(err);
      res.status(400).send("Image not accessible.");
    }

    console.log(`\nGot rekog response!\n${util.inspect(rekogRes)}\n`);
    res.end(rekogRes);
    // Parse rekRes into vetcor of labels
    //    let rekogData = rekogRes.Labels.map(item => item.Name);
    //    await dynamo.addPlayerImageSubmission(
    //      gameName,
    //      token,
    //      bucketName + "/" + imgName,
    //      rekogData
    //    );
    //res.end();
  }
);

/* POST round leader chooses the winning submission
 * Expects a JSON body like:
 * {
 *   winningSubmissionIndex: 1
 * }
 * Responds with 200
 */
router.post("/:gameName/choice", async (req, res) => {
  const gameName = req.params.gameName;
  const game = await dynamo.getGameState(gameName);
  if (!game) {
    return res.status(404).send("No game of that name.");
  }
  await dynamo.addRoundLeaderChoice(
    gameName,
    req.token,
    req.body.winningSubmissionIndex
  );
  res.end();
});

module.exports = router;
