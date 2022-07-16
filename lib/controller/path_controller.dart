import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class PathController {
  static Future<String> getCurrentDir() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static String getSettingDir() {
    final String current = Directory.current.path;
    final String settingDirPath = p.join(current, 'setting');

    return settingDirPath;
  }

  static String getOutputDir() {
    final String current = Directory.current.path;
    final String settingDirPath = p.join(current, 'output');

    return settingDirPath;
  }

  static bool checkExistJson(String name) {
    final String dir = PathController.getSaveJsonFilePath(name);
    final File file = File(dir);
    return file.existsSync();
  }

  static String getSaveJsonFilePath(String fileName) {
    final String dir = getSettingDir();
    final String filePath = p.join(dir, '$fileName.json');

    return filePath;
  }

  // NOTE: ahkファイルは中間ファイルのため、固定の名前( output.ahk )にして変更できないようにする
  static String getAhkFilePath() {
    final String dir = getOutputDir();
    final String filePath = p.join(dir, 'output.ahk');

    return filePath;
  }

  static String getExeFilePath() {
    final String dir = getOutputDir();
    final String filePath = p.join(dir, 'output.exe');

    return filePath;
  }
}
