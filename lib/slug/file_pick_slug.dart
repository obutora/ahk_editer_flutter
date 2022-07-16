import 'dart:io';

import 'package:ahk_editor_flutter/controller/file_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Widget slugFilePick(context) => ElevatedButton(
      child: const Text('read File'),
      onPressed: () async {
        FilePickerResult? picked = await FilePicker.platform
            .pickFiles(type: FileType.custom, allowedExtensions: ['json']);
        // print(picked);

        if (picked != null) {
          final history =
              await FileController.loadDrugHistory(picked.files.first.path!);
          print(history);
        }
      },
    );

Widget slugGenerateExe(context) => ElevatedButton(
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
                  ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      },
    );
