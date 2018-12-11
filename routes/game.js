var express = require("express");
var router = express.Router();

/*
 * This is the /game router!
 */

// GET home page
router.get("/", function(req, res, next) {
  res.send(
    "Hello world! Ready to throw some apples at an AI to see what sticks?"
  );
});

// POST init a new game
router.post("/");

// POST a new player enters a game
router.post("/:gameId/player");

// GET game state
router.get("/:gameId");

// POST round leader sets the word for the round
router.post("/:gameId/word");

// POST player uploads their image submission for the round
router.post("/:gameId/submission");

// POST round leader chooses the winning submission
router.post("/:gameId/submission");

module.exports = router;
