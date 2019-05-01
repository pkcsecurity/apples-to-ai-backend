import 'package:flutter/material.dart';
import 'package:app/view/widgets/color.dart';

class AnimatedFormChild extends StatelessWidget {
  final Widget child;
  final AnimationController controller;
  final Animation animation;
  final double start;
  final double end;
  AnimatedFormChild(this.child, this.controller, this.animation, this.start, this.end);

  @override
  Widget build(BuildContext context){
    final mediaData = MediaQuery.of(context);
    final width = mediaData.size.width;

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget _){
        return Container(
          transform: Matrix4.translationValues(animation.value * end, start, 0.0),
          child: this.child,
        );
      }
    );
  }
}
