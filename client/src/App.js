import React, { Component } from "react";
import "./App.css";
import Splash from "./Splash.js";

class App extends Component {
  constructor(props) {
    super(props);
    this.state = { currentScreen: "Splash" };
  }

  renderScreen(screenName) {
    console.log(`renderScreen got ${screenName}`);
    switch (screenName) {
      case "Splash":
        return <Splash />;
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
