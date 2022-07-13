import 'dart:io';

import 'package:ahk_editor_flutter/widgets/navigation/navi_rail.dart';
import 'package:ahk_editor_flutter/widgets/theme/material_theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialTheme(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            const NaviRail(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('実行用ファイルを作成する'),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
