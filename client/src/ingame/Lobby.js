import React, { Component } from "react";

class Lobby extends Component {
  constructor(props) {
    super(props);
    this.startGame = this.startGame.bind(this);
    this.state = {};
  }

  startGame() {
    console.log("hit backend to start game");
    this.props.nextStep();
  }

  render() {
    return this.props.owner ? (
      <div className="Lobby">
        <button onClick={this.startGame}>Start Game!</button>
      </div>
    ) : (
      <div className="Lobby">
        <p>Waiting for owner to start the game</p>
        <button onClick={this.props.nextStep}>Next Step</button>
      </div>
    );
  }
}

export default Lobby;
