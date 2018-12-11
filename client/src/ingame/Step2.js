import React, { Component } from "react";

class Step2 extends Component {
  state = { welcomeBanner: "" };

  componentDidMount() {
    console.log("do a thing");
  }

  render() {
    return (
      <div className="Step2">
        <p>A thing</p>
      </div>
    );
  }
}

export default Step2;
