import React, { Component } from "react";

class Lobby extends Component {
  state = { welcomeBanner: "" };

  componentDidMount() {
    console.log("do a thing");
  }

  render() {
    return (
      <div className="Lobby">
        <p>A thing</p>
      </div>
    );
  }
}

export default Lobby;
