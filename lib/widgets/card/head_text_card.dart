import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/text.dart';

class HeadTextCard extends StatelessWidget {
  const HeadTextCard({Key? key, required this.title, required this.description})
      : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: headText,
        ),
        const SizedBox(height: 4),
        FittedBox(
          child: Text(
            description,
            style: captionText1,
          ),
        ),
      ],
    );
  }
}
