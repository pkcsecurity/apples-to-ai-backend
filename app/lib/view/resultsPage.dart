import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:app/view/widgets/color.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: <Widget>[
              _background(),
              //_iconBackground(context),
              _titleBar(context),
              _mainStatistic(context),
              _mainDescriptor(context),
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                children: <Widget>[
//                  _titleWidget(context),
//                  _subTitleWidget(context),
//                  _cameraIcon(context),
//                  _uploadButton(context),
//                ],
//              )
            ]
        )
    );
  }


  Widget _background() {
    return Container(
        decoration: BoxDecoration(
            color: LightOliveGreen,
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/backgrounds/3.0x/bgCircles.png'),
              fit: BoxFit.cover,
            )
        )
    );
  }

  Widget _titleBar(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;

    return SafeArea(
        child: Container(
            constraints: BoxConstraints.expand(height: height * .06),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                  color: DarkOliveGreen,
                  width: 1.0,
                )
                )
            ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _titleText(),
              //_titleBarIcon(context),
            ],
          )
        )
    );
  }

  Widget _titleText() {
    return Text(
      "Results",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.0,
        color: Colors.white,
      ),
    );
  }

  Widget _titleBarIcon(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final width = mediaData.size.height;

    return SvgPicture.asset(
      'assets/images/icons/menu.svg',
      color: Colors.white,
      height: 18.0,);
  }


  Widget _mainStatistic(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    final topText = 'With a'.toUpperCase();
    final confidence = 95;
    final lowerText = 'Confidence level...'.toUpperCase();

    return Positioned(
      top: height * .158,
      left: width * .085,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _mainSubText(topText),
          _mainText('${confidence.toString()}%'),
          _mainSubText(lowerText),
          
        ],
      )
    );
  }
  
  Widget _mainSubText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
        letterSpacing: 1.6,
        color: Colors.white,
      ),
    );
  }

  Widget _mainSubAltText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        letterSpacing: 0.0,
        color: Colors.white,
      ),
    );
  }
  
  Widget _mainText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w200,
        fontSize: 75.0,
        color: Colors.white,
      ),
    );
  }


  Widget _mainDescriptor(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    final topText = 'Rico says it\'s a:'.toUpperCase();
    final item = 'Taco';
    final lowerText = 's for everyone!!!';

    return Positioned(
        top: height * .343,
        right: width * .093,
        width: width * .406,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _mainSubText(topText),
            _mainText('${item.toUpperCase()}!'),
            _mainSubAltText('$item$lowerText'),
          ],
        )
    );

  }

  Widget _iconBackground(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;
    
    return Positioned(
      top: height * .216,
      left: width * .093,
      right: width * .093,
      child: SvgPicture.asset(
        'asset/images/icons/icon-taco.svg',
        color: Colors.black.withOpacity(0.05),
        width: width * .814,
      ),
    );

  }


  Widget _titleWidget(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final top = height * .213;

    return Container(
        padding: EdgeInsets.only(top: top),
        child: Text(
            "Take Your Best Shot!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            )
        )
    );
  }

  Widget _subTitleWidget(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final top = height * .017;

    final text = "Let's see if you can outsmart our AI, Rico.".toUpperCase();
    return Container(
        padding: EdgeInsets.only(top: top),
        child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12.0,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w500,
                color: Colors.white
            )
        ));
  }

  Widget _cameraIcon(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return Container(
      padding: EdgeInsets.only(top: height *.081),
      child: SvgPicture.asset(
        'assets/images/icons/icon-camera.svg',
        width: width * .4,
        height: height * .141,
        color: Colors.white.withOpacity(.45),
      ),
    );
  }

  Widget _uploadButton(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return Container(
        padding: EdgeInsets.only(
          top: height * .113,
          right: width * .1665,
          left: width * .1665,
        ),


        child: RaisedButton(
          child: Container(
            //padding: EdgeInsets.symmetric(horizontal: width * 0.66),
              constraints: BoxConstraints(minHeight: height * .06,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buttonText(),
                  _buttonIcon(context),
                ],
              )
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          color: LightOliveGreen,
          onPressed: () {
            print('pressed');
          },
        )
    );
  }

  Widget _buttonText() {
    final text = "Upload a photo".toUpperCase();
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: 16.0,
      ),
    );
  }

  Widget _buttonIcon(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return SvgPicture.asset(
      'assets/images/icons/icon-upload.svg',
      color: Colors.white,
      width: 24.0,
      height: 24.0,
    );
  }
}