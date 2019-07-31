import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/bloc/userBloc.dart';
import 'package:app/view/widgets/button.dart';
import 'package:app/view/widgets/color.dart';
import 'package:app/view/widgets/misc.dart';
import 'package:app/view/widgets/input.dart';

class LoginPage extends StatelessWidget{
  final userBloc = UserBloc.instance;

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
            inputField("Password", "", secure: true),
            _signInButton(context),
            _registerButton(context),
            _playButton(context)
          ],
        )
      ),
      color: LightBlue
    );
  }

  Widget _signInButton(BuildContext context){
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
        "Sign In",
        LightOliveGreen,
        Colors.white,
        action: () {
          userBloc.handleSignIn().then((FirebaseUser user) {
            print('Signed in user: $user');
          }).catchError((e) {
            print('Caught exception $e');
          });
        }
      )
    );
  }

  Widget _registerButton(BuildContext context){
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
        "Register",
        LightOliveGreen,
        Colors.white,
        action: () {
          //userBloc.createUserWithEmailAndPassword('sreeves+1@pkc.io', 'security-first-password');
          Navigator.of(context).pushNamed('/register');
        }
      )
    );
  }

  Widget _playButton(BuildContext context){
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
            "Just Play",
            LightOliveGreen,
            Colors.white,
            action: () {
              // userBloc.loginWithPhoneNumber('+16268238397');

              //Navigator.of(context).pushNamed('/home');
            }
        )
    );
  }
}

