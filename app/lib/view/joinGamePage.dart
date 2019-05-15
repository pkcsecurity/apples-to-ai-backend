import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/view/widgets/button.dart';
import 'package:app/view/widgets/color.dart';
import 'package:app/view/widgets/input.dart';
import 'package:app/view/widgets/misc.dart';

class JoinGamePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return circlesSplashBackground(
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
            Text(
              "Join the game your friend created\nand have fun with them!",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue,
                fontSize: 20.0
              ),
            ),
            inputField("Enter a Game Code", "An Awesome Code From My Awesome Friend"),
            _joinButton(context)
          ],
        )
      ),
      color: LightBlue
    );
  }

  Widget _joinButton(BuildContext context){
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return Container(
      padding: EdgeInsets.only(
        top: height * .02,
        right: width * .1665,
        left: width * .1665,
      ),
      child: raisedButton(
        "Let's Play!",
        LightOliveGreen,
        Colors.white,
        action: () => Navigator.of(context).popUntil((Route r) => r.settings.name == '/home')
      )
    );
  }
}
