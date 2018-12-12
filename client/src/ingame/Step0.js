import React, { Component } from "react";

class Step0 extends Component {
  constructor(props) {
    super(props);
    this.submit = this.submit.bind(this);
    this.state = { word: "" };
  }

  handleChange(event) {
    this.setState({ [event.target.name]: event.target.value });
  }

  submit(event) {
    event.preventDefault();
    console.log("hit backend with the chosen word for the round");
    this.props.nextStep();
  }

  render() {
    return this.props.owner ? (
      <div className="Step0">
        <form onSubmit={this.submit}>
          <label>
            Word
            <input
              name="word"
              type="text"
              value={this.state.word}
              onChange={this.handleChange}
            />
          </label>
          <input type="submit" value="Submit" />
        </form>
      </div>
    ) : (
      <div className="Step0">
        <p>Waiting for owner to choose a word</p>
        <button onClick={this.props.nextStep}>Next Step</button>
      </div>
    );
  }
}

export default Step0;
