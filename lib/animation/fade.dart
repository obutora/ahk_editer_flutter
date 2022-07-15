import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  const FadeAnimation({
    Key? key,
    required this.child,
    this.durationInMilliseconds = 1200,
    this.curve = Curves.easeOutCirc,
    this.delayInMilliseconds = 0,
    this.control = CustomAnimationControl.playFromStart,
  }) : super(key: key);

  final int durationInMilliseconds;
  final Curve curve;
  final int delayInMilliseconds;
  final CustomAnimationControl control;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomAnimation(
      control: control,
      delay: Duration(milliseconds: delayInMilliseconds),
      curve: curve,
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: durationInMilliseconds),
      child: child,
      builder: (context, widget, double value) {
        return Opacity(
          opacity: value,
          child: widget,
        );
      },
    );
  }
}
