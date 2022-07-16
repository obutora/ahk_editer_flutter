import 'dart:convert';
import 'dart:io';

import 'package:ahk_editor_flutter/controller/path_controller.dart';
import 'package:ahk_editor_flutter/entity/drug_history.dart';
import 'package:charset_converter/charset_converter.dart';

class FileController {
  // NOTE : historyのIdをファイル名として保存
  static Future<void> saveDrugHistory(DrugHistory history) async {
    final String dir = await PathController.getSaveJsonFilePath(history.id);
    final String json = jsonEncode(history);
    final File file = File(dir);
    await file.writeAsString(json);

    // print('saveDrugHistory: $dir');
  }

  static deleteJson(DrugHistory history) async {
    final Directory dir =
        Directory(await PathController.getSaveJsonFilePath(history.id));
    dir.deleteSync(recursive: true);
  }

  //
  static Future<void> saveAhk(String ahkBody) async {
    // NOTE : ahkファイルは中間ファイルのため、固定の名前( output.ahk )にして変更できないようにする
    final String dir = await PathController.getAhkFilePath();
    final File file = File(dir);

    final encoded = await CharsetConverter.encode("Shift_JIS", ahkBody);
    await file.writeAsBytes(encoded);

    // print('saveAhk: $dir');
  }

  static Future<DrugHistory> loadDrugHistory(String path) async {
    final File file = File(path);
    final String json = await file.readAsString();
    final DrugHistory history = DrugHistory.fromJson(jsonDecode(json));

    return history;
  }

  static Future<List<DrugHistory>> loadAllDrugHistory() async {
    // final Directory dir = Directory(dirPath);
    final Directory dir = Directory(PathController.getSettingDir());
    final List<FileSystemEntity> files = await dir.list().toList();
    final List<DrugHistory> histories = [];
    for (final FileSystemEntity entity in files) {
      final String path = entity.path;
      final DrugHistory history = await loadDrugHistory(path);
      histories.add(history);
    }

    return histories;
  }
}
