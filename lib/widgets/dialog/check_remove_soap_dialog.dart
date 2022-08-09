import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../entity/soap.dart';
import '../../provider/editing_history_provider.dart';
import '../theme/color.dart';
import '../theme/text.dart';

Future<dynamic> checkRemoveSoapLineDialog(
  BuildContext context,
  WidgetRef ref,
  Soap soap,
) {
  return showDialog(
      context: context,
      builder: (context) {
        final setHistory = ref.watch(editingHistoryProvider.notifier);
        return AlertDialog(
          titleTextStyle: bodyText1,
          title: Text(
            soap.body,
          ),
          content: const Text(
            'この行を削除してよろしいですか？',
            style: captionText1,
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kSecondaryGray.withOpacity(0.4),
              ),
              child:
                  Text('キャンセル', style: inputText.copyWith(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kAlertRed,
              ),
              child:
                  Text('削除する', style: inputText.copyWith(color: Colors.white)),
              onPressed: () {
                setHistory.removeSoap(soap.id);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
