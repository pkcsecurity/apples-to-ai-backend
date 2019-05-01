import 'package:app/view/animatedFormChild.dart';
import 'package:flutter/material.dart';
import 'package:app/view/widgets/color.dart';

class AnimatedForm extends StatefulWidget {
  final List<Widget> children;
  AnimatedForm(this.children);

  @override
  AnimatedFormState createState() {
    return AnimatedFormState(this.children);
  }
}

class AnimatedFormState extends State<AnimatedForm> with TickerProviderStateMixin {
  final List<Widget> children;

  AnimationController _controller;
  Animation _animation;
  int index = 0;
  bool nextPressed = true;

  AnimatedFormState(this.children);

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: -1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn
    ));
  }


  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    final double backPosition = width * -2;
    final double currentPosition = 0;
    final double nextPosition = width * 2;

    return Container(
        child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                    formElement(backPosition, currentPosition),
                    formElement(currentPosition, nextPressed ? backPosition : nextPosition),
                    formElement(nextPosition, currentPosition),
                  ],
              ),
              _buttons(context),
            ]
        )
    );
  }

  Widget formElement (double start, double end, {bool first = false, bool last = false}) {
    if (first && index > 0 ||
        last && index < children.length -1  ||
        !first && !last) {
      final delta = first ? -1 : last ? 1 : 0;

      return AnimatedFormChild(
        children[index + delta],
        _controller,
        _animation,
        start,
        end,
      );
    } else {
      return Container();
    }
  }


  Widget _buttons(BuildContext context) {
    final nextButton = index < children.length - 1 ? _button(context, "Next", next) : Container();
    final backButton = index > 0 ? _button(context, "Back", back) : Container();

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
      print('Next Button');
      _controller.forward().then((_) =>
          setState(() {
            nextPressed = true;
            index += 1;
          })
      );

    } else {
      print("There are no more elements");
    }
  }

  void back() {
    if (index > 0 ) {
      print('Back button');
      _controller.reverse().then((_) =>
          setState(() {
            nextPressed = false;
            index -= 1;
          })
      );
    } else {
      print("There are no more elements in the begining of the list");
    }
  }
}