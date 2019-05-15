import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:app/view/widgets/color.dart';
import 'package:app/view/widgets/misc.dart';

class WelcomePage extends StatefulWidget {
  @override
  WelcomePageState createState() {
    return WelcomePageState();
  }
}

class WelcomePageState extends State<WelcomePage> {
  @override
  initState() {
    super.initState();
    new Timer(const Duration(seconds: 3), goToHomePage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
          bgCirclesBackground(color: LightOliveGreen),
          _welcomeText(context),
          _icon(context)
        ]
      )
    );
  }

  Widget _welcomeText(BuildContext context){
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return Positioned(
      top: height * .25,
      left: width * .05,
      right: width * .05,
      child: Text(
        "Welcome to Apples to AI!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
          color: Colors.white,
        ),
      )
    );
  }

  Widget _icon(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return Positioned(
      top: height * .40,
      left: width * .25,
      right: width * .25,
      child: SvgPicture.asset(
        'assets/images/icons/icon-logo.svg',
        color: Colors.white,
        width: width * .5,
      ),
    );
  }

  void goToHomePage(){
    Navigator.of(context).pushNamed('/home');
  }
}
