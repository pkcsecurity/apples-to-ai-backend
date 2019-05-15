import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/view/widgets/color.dart';

Widget circlesSplashBackground({Widget child, Color color}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      image: DecorationImage(
        image: AssetImage('assets/images/backgrounds/3.0x/bgCirclesSplash.png'),
        fit: BoxFit.cover,
      )
    ),
    child: child
  );
}

Widget bgCirclesBackground({Widget child, Color color}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      image: DecorationImage(
        image: AssetImage(
          'assets/images/backgrounds/3.0x/bgCircles.png'),
        fit: BoxFit.cover,
      )
    ),
    child: child
  );
}

Widget drawerBackground({Widget child, Color color}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      image: DecorationImage(
        image: AssetImage(
          'assets/images/backgrounds/3.0x/drawer_background.png'),
        fit: BoxFit.cover,
        )
      ),
    child: child
  );
}