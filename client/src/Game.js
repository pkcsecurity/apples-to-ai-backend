import React, { Component } from "react";
import Lobby from "./ingame/Lobby";
import Step0 from "./ingame/Step0";
import Step1 from "./ingame/Step1";
import Step2 from "./ingame/Step2";
import Endgame from "./ingame/Endgame";

class Game extends Component {
  constructor(props) {
    super(props); // Get prop gameName and playerToken
    this.nextStep = this.nextStep.bind(this);
    this.state = { step: 0, playerIsOwner: false };
  }

  componentDidMount() {
    console.log("hit backend to determine if current player is owner");
  }

  nextStep() {
    this.setState(oldState => {
      return { step: oldState.step + 1 };
    });
  }

  render() {
    switch (this.state.step) {
      case 0: // Lobby
        return (
          <Lobby owner={this.state.playerIsOwner} nextStep={this.nextStep} />
        );
      case 1: // word choice
        return <Step0 nextStep={this.nextStep} />;
      case 2: // player submit
        return <Step1 nextStep={this.nextStep} />;
      case 3: // winning pick
        return <Step2 nextStep={this.nextStep} />;
      case 4: // endgame
        return (
          <Endgame
            nextRound={() => {
              this.setState({ step: 1 });
            }}
            goToLobby={() => {
              this.setState({ step: 0 });
            }}
          />
        );
      default:
        return <p>Broke</p>;
    }
  }
}

export default Game;
