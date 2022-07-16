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

  static Future<String> getOutputDir() async {
    final String current = Directory.current.path;
    final String settingDirPath = p.join(current, 'output');

    return settingDirPath;
  }

  static Future<String> getSaveJsonFilePath(String fileName) async {
    final String dir = getSettingDir();
    final String filePath = p.join(dir, '$fileName.json');

    return filePath;
  }

  // NOTE: ahkファイルは中間ファイルのため、固定の名前( output.ahk )にして変更できないようにする
  static Future<String> getAhkFilePath() async {
    final String dir = await getOutputDir();
    final String filePath = p.join(dir, 'output.ahk');

    return filePath;
  }

  static Future<String> getExeFilePath() async {
    final String dir = await getOutputDir();
    final String filePath = p.join(dir, 'output.exe');

    return filePath;
  }
}
