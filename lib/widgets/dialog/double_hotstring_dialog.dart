import 'package:ahk_editor_flutter/entity/drug_history.dart';
import 'package:ahk_editor_flutter/widgets/card/mini_soap_card.dart';
import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controller/file_controller.dart';
import '../../provider/edit_step_provider.dart';
import '../../provider/editing_history_provider.dart';
import '../../provider/history_store_provider.dart';

//NOTE : hotKeyで重複がないか確認。重複がある場合はどちらを残すか決める。
Future<dynamic> doubleHotstringDialog(BuildContext context, WidgetRef ref) {
  return showDialog(
      context: context,
      builder: (context) {
        final editingHistory = ref.watch(editingHistoryProvider);
        final setHistoryStore = ref.watch(historyStoreProvider.notifier);
        final setEditState = ref.watch(editingHistoryProvider.notifier);
        final setEditStep = ref.watch(editStepProvider.notifier);

        final pastHistory =
            setHistoryStore.getHistoryFromHotString(editingHistory.hotString);

        return SimpleDialog(
          title: Text(
            'ホットキーが重複しています。',
            style: headText2.copyWith(color: kSecondaryGray),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          children: [
            Text(
              'どちらかを選ぶか、キャンセルから現在編集しているホットキーを変更してください。',
              style: bodyText2.copyWith(color: kSecondaryGray),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                CompareSoapCard(
                  history: editingHistory,
                  title: '現在編集しているデータ',
                  onPressed: () async {
                    //NOTE : 現在編集しているものを残す場合は、過去のものを削除するため、
                    //StateからHotStringに該当する.jsonのファイル名を読み込み、json削除後に新しいjsonを作成する。

                    //json削除
                    await FileController.deleteJson(pastHistory);

                    //State削除
                    setHistoryStore.remove(pastHistory);

                    //State追加、json保存, stepとStateのクリア
                    FileController.saveDrugHistory(editingHistory);
                    setHistoryStore.add(editingHistory);

                    setEditState.clear();
                    setEditStep.clear();

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8),
                CompareSoapCard(
                  history: pastHistory,
                  title: '過去のデータ',
                  onPressed: () {
                    //NOTE: 過去のデータを選択した場合は、Stateをクリアして初期画面に戻る
                    setEditState.clear();
                    setEditStep.clear();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Spacer(),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'キャンセル',
                      style: inputText.copyWith(color: kPrimaryGreen),
                    )),
              ],
            )
          ],
        );
      });
}

class CompareSoapCard extends StatelessWidget {
  const CompareSoapCard(
      {Key? key,
      required this.history,
      required this.title,
      required this.onPressed})
      : super(key: key);

  final DrugHistory history;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
              border:
                  Border.all(color: kSecondaryGray.withOpacity(0.16), width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: captionText1.copyWith(color: kSecondaryGray),
                ),
                const SizedBox(
                  height: 4,
                ),
                MiniSoapCard(history: history),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryGreen,
                        ),
                        onPressed: onPressed,
                        child: Text(
                          'こちらを残す',
                          style: inputText.copyWith(color: Colors.white),
                        ))
                  ],
                )
              ],
            )));
  }
}
