import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/color.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.onPressed,
    this.icon = CupertinoIcons.add,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: kPrimaryGreen,
            elevation: 0),
        onPressed: onPressed,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
