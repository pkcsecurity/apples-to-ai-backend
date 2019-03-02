import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:app/view/widgets/color.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[_background(), _icon(context)]));
  }

  Widget _background() {
    return Container(
        decoration: BoxDecoration(
            color: LightOliveGreen,
            image: DecorationImage(
              image: AssetImage('assets/images/backgrounds/3.0x/bgCircles.png'),
              fit: BoxFit.contain,
            )));
  }

  Widget _icon(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return Positioned(
      top: height * .25,
      left: width * .25,
      right: width * .25,
      child: SvgPicture.asset(
        'assets/images/icons/icon-logo.svg',
        color: Colors.white,
        width: width * .5,
      ),
    );
  }
}
