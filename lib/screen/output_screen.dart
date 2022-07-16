import 'package:ahk_editor_flutter/widgets/card/head_text_card.dart';
import 'package:ahk_editor_flutter/widgets/navigation/navi_rail.dart';
import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:ahk_editor_flutter/widgets/theme/material_theme.dart';
import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/ahk_controller.dart';
import '../controller/file_controller.dart';
import '../entity/drug_history.dart';
import '../provider/history_store_provider.dart';
import '../widgets/dialog/success_failed_dialog.dart';

class OutputScreen extends ConsumerWidget {
  const OutputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setHistoryStore = ref.watch(historyStoreProvider.notifier);
    final historyStore = ref.watch(historyStoreProvider);

    return MaterialTheme(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const NaviRail(),
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
                child: ListView(
                  // shrinkWrap: true,
                  children: [
                    const HeadTextCard(
                        title: '実行用ファイルを出力します',
                        description: '''薬歴/トレース入力用の実行用ファイルを出力できます。'''),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: kPrimaryGreen.withOpacity(0.16)),
                          child: Column(
                            children: const [
                              Text(
                                '・作成ボタンを押すと英語のダイアログが出ますが、OKを押してください',
                                style: captionText1,
                              ),
                              Text(
                                '・入力用ツールをすでに実行中の場合は必ず閉じてから使用してください',
                                style: captionText1,
                              ),
                            ],
                          ),
                        ),
                        const Spacer()
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryGreen,
                          ),
                          icon: const Icon(
                            CupertinoIcons.checkmark_seal_fill,
                            color: Colors.white,
                          ),
                          label: Text('実行用ファイルを作成する',
                              style: inputText.copyWith(color: Colors.white)),

                          // NOTE : 実行用ファイル作成
                          onPressed: () async {
                            final String result =
                                AhkController.historyListToAhkString(
                                    historyStore);

                            await FileController.saveAhk(result);
                            final bool isSuccess =
                                await AhkController.generateAhkExe();

                            // ignore: use_build_context_synchronously
                            openSuccessFailedDialog(context, isSuccess);
                          },
                        ),
                        const Spacer()
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      thickness: 0.3,
                      color: kSecondaryGray,
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: historyStore.map((DrugHistory history) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 4,
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: kPrimaryGreen.withOpacity(0.16)),
                            // color: kPrimaryGreen.withOpacity(0.16),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(history.hotString, style: headText3),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  ...history.soapList.map((soap) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: soap.soap != 'ト'
                                                ? kPrimaryGreen
                                                : kInfoBlue,
                                            radius: 16,
                                            child: Text(soap.soap,
                                                style: bodyText1.copyWith(
                                                    color: Colors.white)),
                                          ),
                                          const SizedBox(width: 8),
                                          Flexible(
                                              child: Text(soap.body,
                                                  style: bodyText2)),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: IconButton(
                                  icon: const Icon(
                                    CupertinoIcons.xmark_circle,
                                    color: kAlertRed,
                                  ),
                                  onPressed: () async {
                                    await FileController.deleteJson(history);

                                    setHistoryStore.remove(history);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
