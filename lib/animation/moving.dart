import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum MoveDirection {
  leftIn,
  rightIn,
  topIn,
  bottomIn,
}

class EasingAnimation extends StatelessWidget {
  const EasingAnimation({
    Key? key,
    required this.child,
    this.moveAmount = 300,
    this.moveDirection = MoveDirection.leftIn,
    this.durationInMilliseconds = 600,
    this.curve = Curves.easeOutCirc,
    this.delayInMilliseconds = 0,
    this.control = CustomAnimationControl.playFromStart,
  }) : super(key: key);

  final double moveAmount;
  final MoveDirection moveDirection;
  final int durationInMilliseconds;
  final Curve curve;
  final int delayInMilliseconds;
  final CustomAnimationControl control;
  final Widget child;

  Offset movingDirection(MoveDirection easing, double value, double amount) {
    switch (easing) {
      case MoveDirection.leftIn:
        return Offset((-1 * value) * amount, 0);

      case MoveDirection.rightIn:
        return Offset(value * amount, 0);

      case MoveDirection.topIn:
        return Offset(0, value * amount);

      case MoveDirection.bottomIn:
        return Offset(0, (-1 * value) * amount);
      default:
        return const Offset(0, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimation(
      control: control,
      delay: Duration(milliseconds: delayInMilliseconds),
      curve: curve,
      tween: Tween<double>(begin: 1, end: 0),
      duration: Duration(milliseconds: durationInMilliseconds),
      child: child,
      builder: (context, widget, double value) {
        return Transform.translate(
          offset: movingDirection(moveDirection, value, moveAmount),
          child: widget,
        );
      },
    );
  }
}
