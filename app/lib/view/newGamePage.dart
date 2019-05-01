import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/view/widgets/color.dart';
import 'package:app/view/animatedFormChild.dart';

class NewGamePage extends StatefulWidget {
  @override
  NewGamePageState createState() {
    return NewGamePageState();    
  }
}

class NewGamePageState extends State<NewGamePage> with TickerProviderStateMixin {
  final GlobalKey<FormFieldState<String>> gameName = GlobalKey<FormFieldState<String>>();
  final AnimationController controller1, controller2;
  final Animation animation1, animation2;

  @override
  Widget build(BuildContext context){
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return _background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: height*0.2,
            ),
            AnimatedForm(
              [AnimatedFormChild(
                controller1,
                animation1,
                Text(
                  "Create a new game and\nplay with your friends!",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                    fontSize: 20.0
                  ),
                )),
               AnimatedFormChild(
                controller2,
                animation2,
                Text(
                  "Second screen",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                    fontSize: 20.0
                  ),
                ))]
            ),
            // Container(
            //   transform: Matrix4.translationValues(_animation.value * width * 2, 0.0, 0.0),
            //   padding: EdgeInsets.only(
            //     top: 20,
            //     left: 20,
            //     right: 20,
            //   ),
            //   child: _textField(context, "Enter Your Game Name", "My Awesome Game"),
            // ),
            // _submitButton(context),
          ],
        )
      )
    );
  }

  // Widget _formComponent() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //       Container(
  //         height: height*0.2,
  //       ),
  //       Text(
  //         "Create a new game and\nplay with your friends!",
  //         style: TextStyle(
  //           fontWeight: FontWeight.w600,
  //           color: Colors.blue,
  //           fontSize: 20.0
  //           ),
  //       ),
  //       Container(
  //         padding: EdgeInsets.only(
  //           top: 20,
  //           left: 20,
  //           right: 20,
  //         ),
  //         child: _textField(context, "Enter Your Game Name", "My Awesome Game"),
  //       ),
  //       _submitButton(context),
  //     ],
  //   );
  // }

  Widget _background({Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: LightBlue,
        image: DecorationImage(
          image: AssetImage('assets/images/backgrounds/3.0x/bgCirclesSplash.png'),
          fit: BoxFit.cover,
        )
      ),
      child: child,
    );
  }

  // Widget _submitButton(BuildContext context) {
  //   final mediaData = MediaQuery.of(context);
  //   final height = mediaData.size.height;
  //   final width = mediaData.size.width;

  //   return Container(
  //     padding: EdgeInsets.only(
  //       top: height * .05,
  //       right: width * .1665,
  //       left: width * .1665,
  //     ),
  //     child: RaisedButton(
  //       child: Container(
  //         constraints: BoxConstraints(minHeight: height * .06,),
  //         child: _buttonText()
  //       ),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
  //       color: LightOliveGreen,
  //       onPressed: () {
  //         if (gameName.currentState.validate()) {
  //           _controller.forward();
  //         }
  //       }
  //     )
  //   );
  // }

  // Widget _buttonText() {
  //   final text = "Let's Play!";
  //   return Center(
  //     child: Text(
  //       text,
  //       style: TextStyle(
  //         fontWeight: FontWeight.w500,
  //         color: Colors.white,
  //         fontSize: 16.0,
  //       ),
  //     )
  //   );
  // }

  // Widget _textField(BuildContext context, String label, String hint) {
  //   final mediaData = MediaQuery.of(context);
  //   final height = mediaData.size.height;
  //   final width = mediaData.size.width;

  //   return TextFormField(
  //     key: gameName,
  //     decoration: InputDecoration(
  //       labelText: "Enter Your Game Name",
  //       hintText: "My Awesome Game",
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(24.0),
  //       ),
  //     ),
  //     validator: (String value) {
  //       return value.isNotEmpty ? null : "Cannot be empty!";
  //     }
  //   );
  // }
}

