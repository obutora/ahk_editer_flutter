import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/ahk_controller.dart';
import '../controller/file_controller.dart';
import '../entity/drug_history.dart';
import '../provider/editing_history_provider.dart';
import '../provider/history_store_provider.dart';
import '../provider/route_index_provider.dart';
import '../widgets/card/head_text_card.dart';
import '../widgets/card/loading_setting_indicator_card.dart';
import '../widgets/card/mini_soap_card.dart';
import '../widgets/dialog/success_failed_dialog.dart';
import '../widgets/navigation/navi_rail.dart';
import '../widgets/theme/color.dart';
import '../widgets/theme/material_theme.dart';
import '../widgets/theme/text.dart';

class OutputScreen extends HookConsumerWidget {
  const OutputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyStore = ref.watch(historyStoreProvider);

    final sliderState = useState(1.0);

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
                      children: const [
                        LoadedSettingIndicatorCard(),
                        Spacer(),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: kPrimaryGreen.withOpacity(0.08)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '・作成ボタンを押すと英語のダイアログが出ますが、OKを押してください',
                                style:
                                    captionText1.copyWith(color: kPrimaryGreen),
                              ),
                              Text(
                                '・入力用ツールをすでに実行中の場合は必ず閉じてから使用してください',
                                style:
                                    captionText1.copyWith(color: kPrimaryGreen),
                              ),
                              Text(
                                '・薬歴/トレースが読み込まれていない場合は、必ずHome画面から読み込んでください',
                                style:
                                    captionText1.copyWith(color: kPrimaryGreen),
                              ),
                            ],
                          ),
                        ),
                        const Spacer()
                      ],
                    ),
                    const SizedBox(height: 16),
                    // NOTE: AHKのSleepの時間を調整するためのスライダー
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('速度/安定度設定',
                              style: headText3.copyWith(
                                fontWeight: FontWeight.w600,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                              '速度のデフォルト値は1です。\n速度はn倍に設定できます。数値が小さいほど速度は速くなりますが、速くするほど安定性が低下します。\n安定性が低下すると行飛びやSOAP違いが発生しやすくなります。\n数値を大きくすると安定性が高くなりますが、実行速度は低下します。',
                              style: captionText1.copyWith()),
                          Slider(
                              min: 0,
                              max: 3,
                              divisions: 12,
                              label: '${sliderState.value}',
                              value: sliderState.value,
                              onChanged: (e) => {sliderState.value = e}),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryGreen,
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
                                    historyStore, sliderState.value);

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
                    Text(
                      '現在のデータ',
                      style: headText2.copyWith(color: kSecondaryGray),
                    ),
                    Text(
                      '実行用ファイルには、現在読み込まれている以下のデータが含まれます。\n実行用ファイル作成後に実行すると、ホットキーを押してスペースを押すと、自動でデータが入力されます。',
                      style: captionText1.copyWith(color: kSecondaryGray),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: historyStore.map((DrugHistory history) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: kSecondaryGray.withOpacity(0.16)),
                            // color: kPrimaryGreen.withOpacity(0.16),
                          ),
                          child: Stack(
                            children: [
                              MiniSoapCard(history: history),
                              Positioned(
                                right: 0,
                                top: 8,
                                child: SoapCardPopupMenuButton(
                                  history: history,
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

class SoapCardPopupMenuButton extends ConsumerWidget {
  const SoapCardPopupMenuButton({
    Key? key,
    required this.history,
  }) : super(key: key);

  final DrugHistory history;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setHistoryStore = ref.watch(historyStoreProvider.notifier);
    final setEditingHistory = ref.watch(editingHistoryProvider.notifier);
    final setNav = ref.watch(routeIndexProvider.notifier);

    return PopupMenuButton(
      // color: kPrimaryGreen.withOpacity(0.16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(width: 3, color: kPrimaryGreen.withOpacity(0.84))),
      child: const Icon(
        CupertinoIcons.ellipsis_vertical,
        color: kSecondaryGray,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                const Icon(CupertinoIcons.pencil, color: kPrimaryGreen),
                const SizedBox(width: 8),
                Text(
                  '編集',
                  style: bodyText2.copyWith(color: kSecondaryGray),
                ),
              ],
            ),
            onTap: () async {
              setEditingHistory.setHistory(history);
              setNav.change(1);
              context.go('/edit');
            },
          ),
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                const Icon(CupertinoIcons.trash, color: kAlertRed),
                const SizedBox(width: 8),
                Text(
                  '削除',
                  style: bodyText2.copyWith(color: kAlertRed),
                ),
              ],
            ),
            onTap: () async {
              await FileController.deleteJson(history);

              setHistoryStore.remove(history);
            },
          ),
        ];
      },
    );
  }
}
