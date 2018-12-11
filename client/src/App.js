import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class App extends Component {
  state = {welcomeBanner: ''}

  componentDidMount() {
    fetch('/game')
      .then(res => res.text())
      .then(welcomeBanner => this.setState({ welcomeBanner }));
  }

  render() {
    return (
      <div className="App">
        <h1>{this.state.welcomeBanner}</h1>
      </div>
    );
  }
}

export default App;
