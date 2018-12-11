Apples to AI!
===

This is gonna be awesome.


## Rest Endpoints
start a new game
POST /game
inits a game, others join by id

POST /game/{id}/player { email: "blah"}
gets back token to participate in that game

GET /game/{id} "returns game state"

POST /game/{id}/word "round leader can set word for current round"

POST /game/{id}/submission
uploads file to s3 and runs rekog on it, updates game object

POST /game/{id}/choice
set winning submission
