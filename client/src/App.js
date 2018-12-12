import React, { Component } from "react";
import "./App.css";
import Splash from "./Splash.js";
import Game from "./Game.js";

class App extends Component {
  constructor(props) {
    super(props);
    this.state = { currentScreen: "Splash", gameName: "", playerToken: "" };
  }

  renderScreen(screenName) {
    switch (screenName) {
      case "Splash":
        return (
          <Splash
            goToLobby={(gameName, playerToken) => {
              this.setState({
                currentScreen: "Game",
                gameName: gameName,
                playerToken: playerToken
              });
            }}
          />
        );
      case "Game":
        return (
          <Game
            gameName={this.state.gameName}
            playerToken={this.state.playerToken}
          />
        );
      default:
        return <p>Guess you broke it.</p>;
    }
  }

  componentDidMount() {
    console.log("main app mounted");
  }

  render() {
    return (
      <div className="App">{this.renderScreen(this.state.currentScreen)}</div>
    );
  }
}

export default App;
