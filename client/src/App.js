import React, { Component } from "react";
import "./App.css";
import Splash from "./Splash.js";
import Game from "./Game.js";

class App extends Component {
  constructor(props) {
    super(props);
    this.state = { currentScreen: "Splash" };
  }

  renderScreen(screenName) {
    switch (screenName) {
      case "Splash":
        return (
          <Splash
            goToLobby={() => {
              this.setState({ currentScreen: "Game" });
            }}
          />
        );
      case "Game":
        return <Game />;
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
