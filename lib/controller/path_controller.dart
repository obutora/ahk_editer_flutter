import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class PathController {
  static Future<String> getCurrentDir() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static Future<String> getSettingDir() async {
    final String current = await getCurrentDir();
    final String settingDirPath = p.join(current, 'setting');

    return settingDirPath;
  }

  static Future<String> getSaveFilePath(String fileName) async {
    final String dir = await getSettingDir();
    final String filePath = p.join(dir, '$fileName.json');

    return filePath;
  }
}
