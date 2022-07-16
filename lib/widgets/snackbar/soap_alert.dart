import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final soapAlertSnackBar = SnackBar(
  backgroundColor: kSecondaryGray,
  content: Row(
    children: [
      const Icon(CupertinoIcons.exclamationmark_triangle_fill,
          color: Colors.white),
      const SizedBox(width: 8),
      Text(
        'SOAPが入力されていません',
        style: inputText.copyWith(color: Colors.white),
      ),
    ],
  ),
  action: SnackBarAction(
    label: '閉じる',
    textColor: Colors.white,
    onPressed: () {},
  ),
);

final hotStringAlertSnackBar = SnackBar(
  backgroundColor: kSecondaryGray,
  content: Row(
    children: [
      const Icon(CupertinoIcons.exclamationmark_triangle_fill,
          color: Colors.white),
      const SizedBox(width: 8),
      Text(
        '自動入力用のキーが設定されていません',
        style: inputText.copyWith(color: Colors.white),
      ),
    ],
  ),
  action: SnackBarAction(
    label: '閉じる',
    textColor: Colors.white,
    onPressed: () {},
  ),
);
