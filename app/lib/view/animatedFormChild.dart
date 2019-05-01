import 'package:flutter/material.dart';
import 'package:app/view/widgets/color.dart';

class AnimatedForm extends StatefulWidget {
  final List<AnimatedFormChild> children;
  AnimatedForm(this.children);

  @override
  AnimatedFormState createState() {
    return AnimatedFormState(this.children);
  }
}

class AnimatedFormState extends State<AnimatedForm> {
  final List<AnimatedFormChild> children;
  AnimatedFormState(this.children);
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          children[index],
          _buttons(context),
        ]
      )
    );
  }

  Widget _buttons(BuildContext context) {
    final nextButton = index < children.length - 1 ? _button(context, "Next", () => print("Next Button!")) : Container();
    final backButton = index > 0 ? _button(context, "Back", () => print("Back Button!")) : Container();

    return Row(
      children: <Widget> [
        nextButton,
        backButton,
      ]
    );
  }

  Widget _button(BuildContext context, String text, Function onPressed) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return Container(
      padding: EdgeInsets.only(
        top: height * .05,
        right: width * .1665,
        left: width * .1665,
      ),
      child: RaisedButton(
        child: Container(
          constraints: BoxConstraints(minHeight: height * .06,),
          child: _buttonText(text)
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        color: LightOliveGreen,
        onPressed: onPressed,
      )
    );
  }

  Widget _buttonText(final String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 16.0,
        ),
      )
    );
  }

  void next() {
    if (index + 1 < children.length) {
      children[index].moveOut();
      children[index +1].moveIn();
    } else {
      print("There are no more elements");
    }
  }

  void back() {
    if (index > 0 ) {
      children[index].moveInReverse();
      children[index - 1].moveOutReverse();
    } else {
      print("There are no more elements in the begining of the list");
    }
  }
}

class AnimatedFormChild extends StatelessWidget with TickerProviderStateMixin{
  final Widget child;
  final AnimationController controller;
  final Animation animation;
  AnimatedFormChild(this.child, this.controller, this.animation);

  // @override
  // void initState() {
  //   super.initState();

  //   _controllerOut =
  //       AnimationController(vsync: this, duration: Duration(seconds: 1));

  //   _animationOut = Tween(begin: 0.0, end: -1.0).animate(CurvedAnimation(
  //     parent: _controllerOut,
  //     curve: Curves.fastOutSlowIn,
  //   ));
  // }

  // @override
  // void dispose() {
  //   _controllerOut.dispose();
  //   _controllerIn.dispose();
  //   super.dispose();
  // }

  // void moveOut() {
  //   _controllerOut.forward();
  // }

  // void moveOutReverse() {
  //   _controllerOut.reverse();
  // }

  // void moveIn() {
  //   _controllerIn.forward();
  // }

  // void moveInReverse() {
  //   _controllerIn.reverse();
  // }

  @override
  Widget build(BuildContext context){
    final mediaData = MediaQuery.of(context);
    final width = mediaData.size.width;

    return AnimatedBuilder(
      animation: _controllerOut,
      builder: (BuildContext context, Widget _){
        return Container(
          transform: Matrix4.translationValues(_animationOut.value * width * 2, 0.0, 0.0),
          child: this.child,
        );
      }
    );
  }
}
