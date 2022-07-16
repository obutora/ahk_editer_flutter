import 'package:ahk_editor_flutter/provider/editing_history_provider.dart';
import 'package:ahk_editor_flutter/widgets/button/add_button.dart';
import 'package:ahk_editor_flutter/widgets/navigation/navi_rail.dart';
import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:ahk_editor_flutter/widgets/theme/input.dart';
import 'package:ahk_editor_flutter/widgets/theme/material_theme.dart';
import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/edit_step_provider.dart';
import '../widgets/_group/edit_soap/selector/edit_soap_input_selector.dart';
import '../widgets/card/head_text_card.dart';

class SoapEditScreen extends ConsumerWidget {
  const SoapEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editStepState = ref.watch(editStepProvider);
    final editingHistoryState = ref.watch(editingHistoryProvider);
    final setEditStep = ref.watch(editStepProvider.notifier);
    final setEditHistory = ref.watch(editingHistoryProvider.notifier);

    return MaterialTheme(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const NaviRail(),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 28),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        editStepState.isSoap
                            ? const HeadTextCard(
                                title: 'SOAP編集',
                                description:
                                    '''自動入力するSOAPを設定することができます。SOAPの一部だけでもOKです。\n血圧が高くなった時、低くなった時などバリエーションを豊かにしておくと便利です。
                        ''',
                                isWithButton: true,
                              )
                            : const HeadTextCard(
                                title: 'トレース編集',
                                description: 'トレースを編集することができます。',
                                isWithButton: true,
                              ),
                        const EditSelecter(), //NOTE: SOAPのインプットをStateに応じて選択
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // NOTE : もどるボタンを表示する条件
                            editStepState.step != 0
                                ? ElevatedButton.icon(
                                    onPressed: () {
                                      setEditStep.back();
                                    },
                                    icon:
                                        const Icon(CupertinoIcons.left_chevron),
                                    label: const Text('前にもどる'),
                                  )
                                : const SizedBox(),
                            const Spacer(),
                            // NOTE: 進むボタンを表示する条件
                            editStepState.step < 2
                                ? ElevatedButton.icon(
                                    onPressed: () {
                                      setEditStep.next(
                                          editingHistoryState, context);
                                    },
                                    icon: const Icon(
                                        CupertinoIcons.right_chevron),
                                    label: const Text('次にすすむ'),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 20,
              right: 20,
              child: CircleAvatar(
                backgroundColor: kAlertRed,
                child: IconButton(
                  onPressed: () {
                    setEditStep.clear();
                    setEditHistory.clear();
                  },
                  icon: const Icon(CupertinoIcons.trash, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddDrugHistoryHotKey extends ConsumerWidget {
  const AddDrugHistoryHotKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drugHistory = ref.watch(editingHistoryProvider);
    final setDrugHistory = ref.watch(editingHistoryProvider.notifier);

    final controller = TextEditingController();

    return LimitedBox(
      maxWidth: MediaQuery.of(context).size.width / 1.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            'この薬歴を自動入力するときのキーを入力してください。',
            style: bodyText1.copyWith(color: kSecondaryGray),
          ),
          const SizedBox(height: 8),
          const Text(
            'たとえば「 @bp1 」がオススメです。\n頭文字を@, 後ろに略語をつけると分かりやすくなります。',
            style: captionText1,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // NOTE : Stateに保存されている薬歴にHotKeyが入っているかどうかで分岐する
              drugHistory.hotString.isNotEmpty
                  ? Text(
                      drugHistory.hotString,
                      style: bodyText1.copyWith(color: kPrimaryGreen),
                    )
                  : Flexible(
                      child: TextField(
                        controller: controller,
                        decoration: StandardInputDecoration('例) @bp1'),
                        style: inputText,
                      ),
                    ),
              const SizedBox(width: 8),
              AddButton(
                  icon: drugHistory.hotString.isEmpty
                      ? CupertinoIcons.check_mark
                      : CupertinoIcons.reply,
                  onPressed: () {
                    //NOTE : HotKeyが入力されていないときはSet,入力されているときはClear、
                    drugHistory.hotString.isEmpty
                        ? setDrugHistory.setHotString(controller.text)
                        : setDrugHistory.clearHotString();
                  })
            ],
          )
        ],
      ),
    );
  }
}

class AddDrugHistoryGroup extends ConsumerWidget {
  const AddDrugHistoryGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingHistoryState = ref.watch(editingHistoryProvider);
    final setHistory = ref.watch(editingHistoryProvider.notifier);

    final controller = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          'この薬歴のグループを入力してください。',
          style: bodyText1.copyWith(color: kSecondaryGray),
        ),
        const SizedBox(height: 8),
        const Text(
          '薬歴にグループを設定すると、一覧画面でグループ分けした薬歴を見れます。\n血圧の薬歴をグループにしたい場合は「血圧」と入力してください。\nグループがなくても登録は可能です。（*非推奨）',
          style: captionText1,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Flexible(
              child: TextField(
                controller: controller,
                decoration: StandardInputDecoration('例) 血圧'),
                style: inputText,
              ),
            ),
            const SizedBox(width: 8),
            AddButton(
                icon: CupertinoIcons.check_mark,
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    setHistory.addGroup(controller.text);
                  }
                })
          ],
        ),
      ],
    );
  }
}
