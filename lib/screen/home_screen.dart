import 'package:ahk_editor_flutter/controller/ahk_controller.dart';
import 'package:ahk_editor_flutter/controller/file_controller.dart';
import 'package:ahk_editor_flutter/widgets/card/head_text_card.dart';
import 'package:ahk_editor_flutter/widgets/card/loading_setting_indicator_card.dart';
import 'package:ahk_editor_flutter/widgets/navigation/navi_rail.dart';
import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:ahk_editor_flutter/widgets/theme/material_theme.dart';
import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/history_store_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setHistoryStore = ref.watch(historyStoreProvider.notifier);

    return MaterialTheme(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            const NaviRail(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadTextCard(
                      title: '設定ファイルを読み込みましょう',
                      description: '''自動入力する薬歴を設定ファイルに追加できます
薬歴を読み込んだら、左のアイコンから薬歴を追加したり削除したりできます。'''),
                  const SizedBox(height: 12),
                  const LoadedSettingIndicatorCard(),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    child: const Text('設定ファイルを読み込む'),
                    onPressed: () async {
                      //NOTE: 設定ファイルを読み込んでStateに設定
                      final historyList =
                          await FileController.loadAllDrugHistory();

                      setHistoryStore.init(historyList);
                    },
                  ),
                  // const SizedBox(
                  //   height: 60,
                  // ),
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.66,
                    child: Divider(
                      height: 0.5,
                      thickness: 0.5,
                      indent: 20,
                      endIndent: 0,
                      color: kPrimaryBlack.withOpacity(0.3),
                    ),
                  ),
                  const HeadTextCard(
                      title: '薬歴の自動入力機能をONにしましょう',
                      description: '''ONにすると、薬歴の自動入力機能を利用できます。
ショートカットキーについての詳細は、左上から3番目のアイコンをクリックすると確認可能です。'''),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton(
                        child: const Text('薬歴の自動入力機能をONにする'),
                        onPressed: () async {
                          AhkController.runAhkExe();

                          await Future.delayed(
                              const Duration(milliseconds: 1500));
                          showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                              title: const Text(
                                '自動入力機能をONにしました',
                                style: headText3,
                              ),
                              children: [
                                SimpleDialogOption(
                                  onPressed: (() => Navigator.pop(context)),
                                  child: Text(
                                    'OK',
                                    textAlign: TextAlign.right,
                                    style: bodyText1.copyWith(
                                        color: kPrimaryGreen),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
