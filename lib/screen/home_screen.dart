import 'package:ahk_editor_flutter/controller/file_controller.dart';
import 'package:ahk_editor_flutter/widgets/card/head_text_card.dart';
import 'package:ahk_editor_flutter/widgets/navigation/navi_rail.dart';
import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:ahk_editor_flutter/widgets/theme/material_theme.dart';
import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/history_store_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                  // ElevatedButton(
                  //   child: const Text('read File'),
                  //   onPressed: () async {
                  //     FilePickerResult? picked = await FilePicker.platform
                  //         .pickFiles(
                  //             type: FileType.custom,
                  //             allowedExtensions: ['json']);
                  //     // print(picked);

                  //     if (picked != null) {
                  //       final history = await FileController.loadDrugHistory(
                  //           picked.files.first.path!);
                  //       print(history);
                  //     }
                  //   },
                  // ),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kPrimaryGreen.withOpacity(0.16)),
                    child: Text(
                      '現在のステータス : ${stateString()}',
                      style: bodyText2.copyWith(color: kPrimaryGreen),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    child: const Text('設定ファイルを読み込む'),
                    onPressed: () async {
                      String? settingDirPath =
                          await FilePicker.platform.getDirectoryPath();

                      if (settingDirPath!.isNotEmpty) {
                        final historyList =
                            await FileController.loadAllDrugHistory(
                                settingDirPath);

                        setHistoryStore.init(historyList);
                      }
                    },
                  ),
                  // ElevatedButton(
                  //   child: const Text('実行用ファイルを作成する'),
                  //   onPressed: () async {
                  //     final result = await Process.run('./ahk/Ahk2Exe.exe', [
                  //       '/in',
                  //       './ahk/btw.ahk',
                  //       '/out',
                  //       './コンパイル済み実行ファイル/result.exe',
                  //       '/bin',
                  //       './ahk/test.bin',
                  //     ]);
                  //     print(result.stdout);

                  //     showDialog(
                  //         context: context,
                  //         builder: (context) {
                  //           return AlertDialog(
                  //             title: const Text('AlertDialog'),
                  //             content: Text(result.stdout),
                  //             actions: <Widget>[
                  //               FlatButton(
                  //                 child: const Text('OK'),
                  //                 onPressed: () {
                  //                   Navigator.of(context).pop();
                  //                 },
                  //               )
                  //             ],
                  //           );
                  //         });
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
