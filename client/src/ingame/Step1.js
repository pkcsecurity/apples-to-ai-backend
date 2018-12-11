import React, { Component } from "react";

class Step1 extends Component {
  state = { welcomeBanner: "" };

  componentDidMount() {
    console.log("do a thing");
  }

  render() {
    return (
      <div className="Step1">
        <p>A thing</p>
      </div>
    );
  }
}

export default Step1;
