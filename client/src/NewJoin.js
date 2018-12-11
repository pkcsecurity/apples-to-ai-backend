import React, { Component } from "react";

class NewJoin extends Component {
  state = { welcomeBanner: "" };

  componentDidMount() {
    console.log("do a thing");
  }

  render() {
    return (
      <div className="NewJoin">
        <p>A thing</p>
      </div>
    );
  }
}

export default NewJoin;
