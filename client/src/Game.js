import React, { Component } from "react";

class Game extends Component {
  state = { welcomeBanner: "" };

  componentDidMount() {
    console.log("do a thing");
  }

  render() {
    return (
      <div className="Game">
        <p>A thing</p>
      </div>
    );
  }
}

export default Game;
