import 'package:flutter/material.dart';

import '../theme/color.dart';
import '../theme/text.dart';

Future<dynamic> openSuccessFailedDialog(
  BuildContext context,
  bool isSuccess,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titleTextStyle: bodyText1,
          title: isSuccess
              ? const Text(
                  '実行用ファイル作成に成功しました',
                )
              : const Text(
                  '実行用ファイル作成に失敗しました',
                ),
          content: isSuccess
              ? const Text(
                  'outputフォルダ/output.exeを実行して動作確認してみましょう',
                  style: captionText1,
                )
              : const Text(
                  'エラーが発生しました',
                  style: captionText1,
                ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryGreen,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
