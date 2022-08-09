import 'package:ahk_editor_flutter/widgets/button/add_button.dart';
import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/editing_history_provider.dart';
import '../../button/group_tag.dart';
import '../../card/soap_card.dart';
import '../../theme/color.dart';
import '../../theme/input.dart';

class EditableHotKeyAndGroup extends ConsumerWidget {
  const EditableHotKeyAndGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setHistory = ref.watch(editingHistoryProvider.notifier);

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
                //NOTE : hotkeyを入力する部分
                ChangeSwichableHistoryProperty(
                  title: 'この薬歴を自動入力するときのキーを入力してください。',
                  description:
                      'たとえば「 @bp1 」がオススメです。\n頭文字を@, 後ろに略語をつけると分かりやすくなります。',
                  hintText: '例) @bp1',
                  // stateValue: editingHistoryState.hotString,
                  // onPressed: (text) {
                  //   //NOTE : HotKeyが入力されていないときはSet,入力されているときはClear、
                  //   editingHistoryState.hotString.isEmpty
                  //       ? setHistory.setHotString(text)
                  //       : setHistory.clearHotString();
                  // },

                  onFocus: (text) {
                    setHistory.setHotString(text);
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                ChangeDrugHistoryProperty(
                  title: 'この薬歴のグループを入力してください。',
                  description:
                      '薬歴にグループを設定すると、一覧画面でグループ分けした薬歴を見れます。\n血圧の薬歴をグループにしたい場合は「血圧」と入力してください。\nグループがなくても登録は可能です。（*非推奨）',
                  hintText: '例) 血圧',
                  onPressed: (String text) {
                    // setHistory.addGroup(text);
                  },
                ),
                // NOTE: tagを表示するためのWidget
                const SizedBox(
                  height: 20,
                ),
                const TagList(),
                const SizedBox(height: 20),
                // const AddAutherToHistory(),
                ChangeSwichableHistoryProperty(
                  title: 'あなたのニックネームを入力してください',
                  description:
                      '作者名を公開することができます。せっかく作ったデータなのでぜひ入力をお願いします。\n* 必須ではありません。',
                  hintText: '例) 薬局 太郎',
                  // stateValue: editingHistoryState.author,
                  // onPressed: (text) {
                  //   //NOTE : HotKeyが入力されていないときはSet,入力されているときはClear、
                  //   editingHistoryState.author.isEmpty
                  //       ? setHistory.setAuther(text)
                  //       : setHistory.clearAuther();
                  // },

                  onFocus: (text) {
                    setHistory.setAuther(text);
                  },
                ),

                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SoapCard(),
      ],
    );
  }
}

class TagList extends ConsumerWidget {
  const TagList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingHistoryState = ref.watch(editingHistoryProvider);

    return SizedBox(
      child: editingHistoryState.group.isNotEmpty
          ? Wrap(
              direction: Axis.horizontal,
              spacing: 8,
              runSpacing: 12,
              children: editingHistoryState.group
                  .map((e) => GroupTag(title: e))
                  .toList(),
            )
          : const SizedBox(),
    );
  }
}

class ChangeDrugHistoryProperty extends ConsumerWidget {
  const ChangeDrugHistoryProperty({
    Key? key,
    required this.title,
    required this.description,
    required this.hintText,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final String description;
  final String hintText;
  final Function(String text) onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          title,
          style: bodyText1.copyWith(color: kSecondaryGray),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: captionText1,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 340,
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: controller,
                  decoration: StandardInputDecoration(hintText),
                  style: inputText,
                  onSubmitted: (text) {
                    if (controller.text.isNotEmpty) {
                      onPressed(controller.text);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              AddButton(
                  icon: CupertinoIcons.check_mark,
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      onPressed(controller.text);
                      // controller.clear();
                    }
                  })
            ],
          ),
        ),
      ],
    );
  }
}

class ChangeSwichableHistoryProperty extends StatelessWidget {
  const ChangeSwichableHistoryProperty({
    Key? key,
    required this.title,
    required this.description,
    required this.hintText,
    // required this.stateValue,
    // required this.onPressed,
    // required this.onSubmitted,
    // required this.onChanged,
    required this.onFocus,
  }) : super(key: key);

  final String title;
  final String description;
  final String hintText;
  // final String stateValue;
  // final Function(String text) onPressed;
  // final Function(String text) onChanged;
  // final Function(String text) onSubmitted;
  final Function(String text) onFocus;

  @override
  Widget build(BuildContext context) {
    // final drugHistory = ref.watch(editingHistoryProvider);
    final controller = TextEditingController();

    return LimitedBox(
      maxWidth: MediaQuery.of(context).size.width / 1.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            title,
            style: bodyText1.copyWith(color: kSecondaryGray),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: captionText1,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: Focus(
              onFocusChange: (hasFocus) {
                onFocus(controller.text);
              },
              child: TextField(
                controller: controller,
                decoration: StandardInputDecoration(hintText),
                style: inputText,
                // onChanged: (text) {
                //   // controller.text = text;
                //   onChanged(text);
                // },

                // onEditingComplete: () {
                //   print(controller.text);
                // },
                // onSubmitted: (text) {
                //   // onPressed(text);
                //   print(text);
                // },
              ),
            ),
          ),
          // Row(
          //   children: [
          //     // NOTE : Stateに保存されている薬歴にHotKeyが入っているかどうかで分岐する
          //     stateValue.isNotEmpty
          //         ? Text(
          //             stateValue,
          //             style: bodyText1.copyWith(color: kPrimaryGreen),
          //           )
          //         : Flexible(
          //             child: TextField(
          //               controller: controller,
          //               decoration: StandardInputDecoration(hintText),
          //               style: inputText,
          //               onSubmitted: (text) {
          //                 // //NOTE : HotKeyが入力されていないときはSet,入力されているときはClear、
          //                 // drugHistory.hotString.isEmpty
          //                 //     ? setDrugHistory.setHotString(controller.text)
          //                 //     : setDrugHistory.clearHotString();

          //                 onPressed(controller.text);
          //               },
          //             ),
          //           ),
          //     const SizedBox(width: 8),
          //     AddButton(
          //         icon: drugHistory.hotString.isEmpty
          //             ? CupertinoIcons.check_mark
          //             : CupertinoIcons.reply,
          //         onPressed: () {
          //           onPressed(controller.text);
          //         })
          //   ],
          // )
        ],
      ),
    );
  }
}
