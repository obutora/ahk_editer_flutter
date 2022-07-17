import 'package:flutter/material.dart';

import '../../entity/drug_history.dart';
import '../theme/color.dart';
import '../theme/text.dart';

class MiniSoapCard extends StatelessWidget {
  const MiniSoapCard({
    Key? key,
    required this.history,
  }) : super(key: key);

  final DrugHistory history;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ホットキー',
          style: captionText1.copyWith(color: kSecondaryGray),
        ),
        Text(history.hotString, style: headText3),
        const SizedBox(
          height: 12,
        ),
        ...history.soapList.map((soap) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: soap.soap != 'ト' ? kPrimaryGreen : kInfoBlue,
                  radius: 16,
                  child: Text(soap.soap,
                      style: bodyText1.copyWith(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                Flexible(child: Text(soap.body, style: bodyText2)),
              ],
            ),
          );
        }).toList(),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const Spacer(),
            Text(
              history.author != '' ? '作成者 : ${history.author}' : '',
              style: captionText1,
            ),
          ],
        )
      ],
    );
  }
}
