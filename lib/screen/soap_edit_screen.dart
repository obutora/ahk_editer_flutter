import 'package:ahk_editor_flutter/provider/editing_history_provider.dart';
import 'package:ahk_editor_flutter/widgets/navigation/navi_rail.dart';
import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:ahk_editor_flutter/widgets/theme/material_theme.dart';
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
