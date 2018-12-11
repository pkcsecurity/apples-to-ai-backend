import React, { Component } from "react";

class Step0 extends Component {
  state = { welcomeBanner: "" };

  componentDidMount() {
    console.log("do a thing");
  }

  render() {
    return (
      <div className="Step0">
        <p>A thing</p>
      </div>
    );
  }
}

export default Step0;
