import React, { Component } from "react";

class Splash extends Component {
  state = { welcomeBanner: "" };

  componentDidMount() {
    console.log("do a thing");
  }

  render() {
    return (
      <div className="Splash">
        <p>A thing</p>
      </div>
    );
  }
}

export default Splash;
