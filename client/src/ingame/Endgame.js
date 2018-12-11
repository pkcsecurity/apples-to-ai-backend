import React, { Component } from "react";

class Endgame extends Component {
  state = { welcomeBanner: "" };

  componentDidMount() {
    console.log("do a thing");
  }

  render() {
    return (
      <div className="Endgame">
        <p>A thing</p>
      </div>
    );
  }
}

export default Endgame;
