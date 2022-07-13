import 'package:flutter/cupertino.dart';

import '../theme/text.dart';

class HeadTextCard extends StatelessWidget {
  const HeadTextCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'SOAP編集',
          style: headText,
        ),
        SizedBox(height: 4),
        FittedBox(
          child: Text(
            '''自動入力するSOAPを設定することができます。SOAPの一部だけでもOKです。\n血圧が高くなった時、低くなった時などバリエーションを豊かにしておくと便利です。
                        ''',
            style: captionText1,
          ),
        ),
      ],
    );
  }
}
