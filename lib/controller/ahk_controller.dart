// void main() {
//   final String s = soapToString('S', 'あいうえお');
//   final String ep = soapToString('EP', 'かきくけこ');

//   final buffer = StringBuffer();
//   const sep = '\n';

//   buffer.writeAll([s, ep], sep);

//   final String result = finalizeSoapString('@hot', buffer.toString());
//   print(result);
// }

import 'dart:io';

import 'package:ahk_editor_flutter/controller/path_controller.dart';
import 'package:ahk_editor_flutter/entity/drug_history.dart';
import 'package:ahk_editor_flutter/entity/soap.dart';

class AhkController {
  //NOTE : コンパイル
  // NOTE : http://ahkwiki.net/Usage
  static Future<bool> generateAhkExe() async {
    final result = await Process.run('./ahk/Ahk2Exe.exe', [
      '/in',
      PathController.getAhkFilePath(),
      '/out',
      PathController.getExeFilePath(),
      '/bin',
      './ahk/test.bin',
    ]);
    print(result.stdout);

    if (result.stdout.toString().contains('Successfully')) {
      return true;
    } else {
      return false;
    }
  }

  static String historyListToAhkString(List<DrugHistory> historyList) {
    final buffer = StringBuffer();
    const sep = '\n\n';

    List<String> ahkStringList = [];

    for (final history in historyList) {
      final String ahkString = historyToAhkString(history);
      ahkStringList.add(ahkString);
    }

    buffer.writeAll([ahkInputMode, ...ahkStringList, ahkTail], sep);

    return buffer.toString();
  }

  static String historyToAhkString(DrugHistory history) {
    List<String> soapTextList = [];
    const String sep = '\n';

    for (Soap soap in history.soapList) {
      final String bodyText = soapToString(soap.soap, soap.body);
      soapTextList.add(bodyText);
    }

    //TODO: 未検証
    final bodyBuffer = StringBuffer();
    bodyBuffer.writeAll(soapTextList, sep);
    final body = bodyBuffer.toString();

    final historyAhkString = finalizeSoapString(history.hotString, body);
    return historyAhkString;
  }

  //NOTE: FnキーによるmusubiのSOAP選択と、textBodyを生成するメソッド
  static String soapToString(String soap, String text) {
    // ignore: constant_identifier_names
    const String soap_Problem_Text = 'send, {F8}'; // #問
    // ignore: constant_identifier_names
    const String soap_S_Text = 'send, {F1}'; // #問
    // ignore: constant_identifier_names
    const String soap_O_Text = 'send, {F2}';
    // ignore: constant_identifier_names
    const String soap_A_Text = 'send, {F3}';
    // ignore: constant_identifier_names
    const String soap_EP_Text = 'send, {F4}';
    // ignore: constant_identifier_names
    const String soap_CP_Text = 'send, {F5}';
    // ignore: constant_identifier_names
    const String soap_OP_Text = 'send, {F6}';

    late String headText;

    switch (soap) {
      case '#':
        headText = soap_Problem_Text;
        break;
      case 'S':
        headText = soap_S_Text;
        break;
      case 'O':
        headText = soap_O_Text;
        break;
      case 'A':
        headText = soap_A_Text;
        break;
      case 'EP':
        headText = soap_EP_Text;
        break;
      case 'CP':
        headText = soap_CP_Text;
        break;
      case 'OP':
        headText = soap_OP_Text;
        break;
      default:
        headText = '';
    }

    final String returnText = text.replaceAll('\n', '`n');
    final String bodyText = 'print("$returnText")';
    final String concat = '$headText\n$bodyText';

    return concat;
  }

// ホットキーとreturnでbodyTextを挟むためのメソッド
  static String finalizeSoapString(String hotString, String body) {
    final String head = '::$hotString::';
    const String backupClip = '''savedClip := ClipboardAll
Clipboard :=''';
    const String restoreClip = 'Clipboard := savedClip';

    const String tail = 'return';

    final buffer = StringBuffer();
    const sep = '\n';

    buffer.writeAll([head, backupClip, body, restoreClip, tail], sep);

    return buffer.toString();
  }

  static const String ahkInputMode = '#Hotstring SI B Z';

  static const String ahkTail = '''print(str)    {
    sleep,100
    Clipboard = %str%
    sleep, 50
    send, ^v
    sleep,100
    send, {Enter 1}
    sleep,100
    return
}
''';
}
