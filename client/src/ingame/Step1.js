import React, { Component } from "react";

class Step1 extends Component {
  constructor(props) {
    super(props);
    this.submit = this.submit.bind(this);
    this.fileInput = React.createRef();
  }

  submit(event) {
    event.preventDefault();
    console.log(
      "hit backend with the uploaded image, bytes in this.fileInput.current.files[0]."
    );
    this.props.nextStep();
  }

  render() {
    return !this.props.owner ? (
      <div className="Step1">
        <form onSubmit={this.submit}>
          <label>
            Image
            <input name="image" type="file" ref={this.fileInput} />
          </label>
          <input type="submit" value="Submit" />
        </form>
      </div>
    ) : (
      <div className="Step1">
        <p>Waiting for players to submit files</p>
        <button onClick={this.props.nextStep}>Next Step</button>
      </div>
    );
  }
}

export default Step1;
