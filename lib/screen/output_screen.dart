import 'dart:io';

import 'package:ahk_editor_flutter/widgets/card/head_text_card.dart';
import 'package:ahk_editor_flutter/widgets/navigation/navi_rail.dart';
import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:ahk_editor_flutter/widgets/theme/material_theme.dart';
import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../entity/drug_history.dart';
import '../provider/history_store_provider.dart';

class OutputScreen extends ConsumerWidget {
  const OutputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setHistoryStore = ref.watch(historyStoreProvider.notifier);
    final historyStore = ref.watch(historyStoreProvider);

    String stateString() {
      if (historyStore.isEmpty) {
        return '設定ファイルが読み込まれていません。';
      } else {
        return '${historyStore.length} 個の薬歴が読み込まれています。';
      }
    }

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
                        description: '''薬歴入力用の実行用ファイルを出力できます。'''),
                    // const SizedBox(height: 12),
                    // Container(
                    //   padding:
                    //       const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       color: kPrimaryGreen.withOpacity(0.16)),
                    //   child: Text(
                    //     '現在のステータス : ${stateString()}',
                    //     style: bodyText2.copyWith(color: kPrimaryGreen),
                    //   ),
                    // ),
                    const SizedBox(height: 40),
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
                      onPressed: () async {
                        final result = await Process.run('./ahk/Ahk2Exe.exe', [
                          '/in',
                          './ahk/btw.ahk',
                          '/out',
                          './コンパイル済み実行ファイル/result.exe',
                          '/bin',
                          './ahk/test.bin',
                        ]);
                        print(result.stdout);

                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('AlertDialog'),
                                content: Text(result.stdout),
                                actions: <Widget>[
                                  FlatButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      },
                    ),
                    const SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: historyStore.map((DrugHistory history) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: kPrimaryGreen.withOpacity(0.16)),
                            // color: kPrimaryGreen.withOpacity(0.16),
                          ),
                          child: Column(
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
                                        backgroundColor: kPrimaryGreen,
                                        radius: 16,
                                        child: Text(soap.soap,
                                            style: bodyText1.copyWith(
                                                color: Colors.white)),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(soap.body, style: bodyText1),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                    // GridView.count(
                    //   shrinkWrap: true,
                    //   crossAxisCount: MediaQuery.of(context).size.width < 600
                    //       ? 2
                    //       : MediaQuery.of(context).size.width < 1000
                    //           ? 3
                    //           : 5,
                    //   children: historyStore.map((DrugHistory history) {
                    //     return Container(
                    //       margin: const EdgeInsets.all(4),
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 20, vertical: 12),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(20),
                    //           // color: kPrimaryGreen.withOpacity(0.16),
                    //           border: Border.all(
                    //               color: kPrimaryGreen.withOpacity(0.16),
                    //               width: 1,
                    //               style: BorderStyle.solid)),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Text(history.hotString, style: headText3),
                    //           const SizedBox(
                    //             height: 12,
                    //           ),
                    //           ...history.soapList.map((soap) {
                    //             return Padding(
                    //               padding: const EdgeInsets.only(bottom: 4),
                    //               child: Row(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.center,
                    //                 mainAxisSize: MainAxisSize.min,
                    //                 children: [
                    //                   CircleAvatar(
                    //                     backgroundColor: kPrimaryGreen,
                    //                     radius: 16,
                    //                     child: Text(soap.soap,
                    //                         style: bodyText1.copyWith(
                    //                             color: Colors.white)),
                    //                   ),
                    //                   const SizedBox(width: 8),
                    //                   Text(soap.body,
                    //                       style: bodyText2.copyWith(
                    //                           fontWeight: FontWeight.w400)),
                    //                 ],
                    //               ),
                    //             );
                    //           }).toList(),
                    //         ],
                    //       ),
                    //     );
                    //   }).toList(),
                    // )
                    // Wrap(
                    //   runSpacing: 4,
                    //   spacing: 12,
                    //   children: historyStore.map((DrugHistory history) {
                    //     return Container(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 20, vertical: 12),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(20),
                    //           color: kPrimaryGreen.withOpacity(0.16)),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Text(history.hotString, style: headText3),
                    //           const SizedBox(
                    //             height: 12,
                    //           ),
                    //           ...history.soapList.map((soap) {
                    //             return Padding(
                    //               padding: const EdgeInsets.only(bottom: 4),
                    //               child: Row(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.center,
                    //                 mainAxisSize: MainAxisSize.min,
                    //                 children: [
                    //                   CircleAvatar(
                    //                     backgroundColor: kPrimaryGreen,
                    //                     radius: 16,
                    //                     child: Text(soap.soap,
                    //                         style: bodyText1.copyWith(
                    //                             color: Colors.white)),
                    //                   ),
                    //                   const SizedBox(width: 8),
                    //                   Text(soap.body, style: bodyText1),
                    //                 ],
                    //               ),
                    //             );
                    //           }).toList(),
                    //         ],
                    //       ),
                    //     );
                    //   }).toList(),
                    // ),
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
