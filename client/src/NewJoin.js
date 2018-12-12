import React, { Component } from "react";

class NewJoin extends Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.createGame = this.createGame.bind(this);
    this.joinGame = this.joinGame.bind(this);
    this.state = { gameName: "", playerEmail: "", playerName: "" };
  }

  handleChange(event) {
    this.setState({ [event.target.name]: event.target.value });
  }

  createGame() {
    console.log("hit backend to create game:");
    console.log(
      `gamename: ${this.props.gameName}, email: ${
        this.props.playerEmail
      }, playerName: ${this.props.playerName}`
    );
  }

  joinGame() {
    console.log("hit backend to create game:");
    console.log(
      `gamename: ${this.props.gameName}, email: ${
        this.props.playerEmail
      }, playerName: ${this.props.playerName}`
    );
  }

  componentDidMount() {
    console.log("do a thing");
  }

  render() {
    return (
      <div className="NewJoin">
        <h3>{this.props.new ? "Create" : "Join"} a Game!</h3>
        <form onSubmit={this.props.new ? this.createGame : this.joinGame}>
          <label>
            Game Name
            <input
              name="gameName"
              type="text"
              value={this.state.gameName}
              onChange={this.handleChange}
            />
          </label>
          <label>
            Player Name
            <input
              name="playerName"
              type="text"
              value={this.state.playerName}
              onChange={this.handleChange}
            />
          </label>
          <label>
            Player Email
            <input
              name="playerEmail"
              type="text"
              value={this.state.playerEmail}
              onChange={this.handleChange}
            />
          </label>
          <input type="submit" value="Submit" />
        </form>
      </div>
    );
  }
}

export default NewJoin;
