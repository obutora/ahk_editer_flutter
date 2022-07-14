import 'dart:convert';
import 'dart:io';

import 'package:ahk_editor_flutter/controller/path_controller.dart';
import 'package:ahk_editor_flutter/entity/drug_history.dart';

class FileController {
  // NOTE : historyのIdをファイル名として保存
  static Future<void> saveDrugHistory(DrugHistory history) async {
    final String dir = await PathController.getSaveFilePath(history.id);
    final String json = jsonEncode(history);
    final File file = File(dir);
    await file.writeAsString(json);

    print('saveDrugHistory: $dir');
  }

  static Future<DrugHistory> loadDrugHistory(String path) async {
    final File file = File(path);
    final String json = await file.readAsString();
    final DrugHistory history = DrugHistory.fromJson(jsonDecode(json));

    return history;
  }

  static Future<List<DrugHistory>> loadAllDrugHistory(String dirPath) async {
    final Directory dir = Directory(dirPath);
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
