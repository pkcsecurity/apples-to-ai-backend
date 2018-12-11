const express = require("express");
const router = express.Router();
const uuid = require("uuid/v4");
const dynamo = require("../dynamodb");

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
  const token = uuid();
  dynamo.initNewGame(req.gameName, token, req.ownerEmail, req.maxScore);
  res.send({ token: token });
});

// POST a new player enters a game
router.post("/:gameId/player");

// GET game state
router.get("/:gameName", (req, res) => {
  const game = dynamo.getGameState(req.params.gameName);
  if (game) {
    res.send(game.GameState);
  } else {
    res.status(404).end();
  }
});

// POST round leader sets the word for the round
router.post("/:gameId/word");

// POST player uploads their image submission for the round
router.post("/:gameId/submission");

// POST round leader chooses the winning submission
router.post("/:gameId/submission");

module.exports = router;
