import React, { Component } from "react";
import NewJoin from "./NewJoin.js";

class Splash extends Component {
  constructor(props) {
    super(props);
    this.newGame = this.newGame.bind(this);
    this.joinGame = this.joinGame.bind(this);
    this.state = { currentScreen: "Splash" };
  }

  newGame() {
    this.setState({ currentScreen: "New" });
  }

  joinGame() {
    this.setState({ currentScreen: "Join" });
  }

  componentDidMount() {
    console.log("splash do a thing");
  }

  render() {
    switch (this.state.currentScreen) {
      case "Splash":
        return (
          <div className="Splash">
            <h2>New game or join?</h2>
            <button onClick={this.newGame}>New Game</button>
            <button onClick={this.joinGame}>Join Game</button>
          </div>
        );
      case "New":
        return <NewJoin new="true" />;
      case "Join":
        return <NewJoin new="false" />;
      default:
        return <p>Guess you splash broke it.</p>;
    }
  }
}

export default Splash;
