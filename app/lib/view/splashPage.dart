import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:app/view/widgets/button.dart';
import 'package:app/view/widgets/color.dart';
import 'package:app/view/widgets/input.dart';
import 'package:app/view/widgets/misc.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
          bgCirclesBackground(color: LightOliveGreen),
          _icon(context)
        ]
      )
    );
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
