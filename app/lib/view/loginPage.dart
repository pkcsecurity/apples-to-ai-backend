import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/view/widgets/button.dart';
import 'package:app/view/widgets/color.dart';
import 'package:app/view/widgets/misc.dart';
import 'package:app/view/widgets/input.dart';

class LoginPage extends StatelessWidget{
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
              height: height*0.1,
            ),
            Text(
              "Apples to AI",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue,
                fontSize: 20.0
              ),
            ),
            inputField("Username", ""),
            inputField("Password", ""),
            raisedButton(context, "Sign In", () => print("Need to validate input")),
            raisedButton(context, "Register", () => Navigator.of(context).pushNamed('/register')),
            raisedButton(context, "Just Play", () => Navigator.of(context).pushNamed('/home'))
          ],
        )
      ),
      color: LightBlue
    );
  }
}
