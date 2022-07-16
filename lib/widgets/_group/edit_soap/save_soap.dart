import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controller/file_controller.dart';
import '../../../provider/edit_step_provider.dart';
import '../../../provider/editing_history_provider.dart';
import '../../../provider/history_store_provider.dart';
import '../../button/group_tag.dart';
import '../../card/soap_card.dart';
import '../../theme/color.dart';
import '../../theme/text.dart';

class SaveSoapWidget extends ConsumerWidget {
  const SaveSoapWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingHistory = ref.watch(editingHistoryProvider);
    final setEditState = ref.watch(editingHistoryProvider.notifier);
    final setEditStep = ref.watch(editStepProvider.notifier);
    final setHistoryStore = ref.watch(historyStoreProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: kSecondaryGray.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  'この薬歴を保存しますか？',
                  style: bodyText1.copyWith(color: kSecondaryGray),
                ),
                const SizedBox(height: 8),
                const Text(
                  'よろしければ、保存ボタンを押してください。\n削除する場合は右上のゴミ箱ボタンを押してください。',
                  style: captionText1,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kPrimaryGreen),
                    onPressed: () async {
                      //NOTE: 薬歴をセーブした後、Stateにも追加する
                      FileController.saveDrugHistory(editingHistory);
                      setHistoryStore.add(editingHistory);

                      setEditState.clear();
                      setEditStep.clear();

                      //NOTE:再読み込みここから
                    },
                    child: Text('保存する',
                        style: inputText.copyWith(color: Colors.white))),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text('入力キー : ${editingHistory.hotString}', style: headText2),
        const SizedBox(height: 12),
        editingHistory.group.isNotEmpty
            ? Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 12,
                children: editingHistory.group
                    .map((e) => GroupTag(title: e))
                    .toList(),
              )
            : const SizedBox(),
        const SizedBox(height: 12),
        const SoapCard(),
      ],
    );
    // return Column(
    //   children: [
    //     ElevatedButton(
    //         onPressed: () async {
    //           FileController.saveDrugHistory(editingHistory);
    //         },
    //         child: const Text('保存する')),
    //   ],
    // );
  }
}
