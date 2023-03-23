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

  static Future<Object> runAhkExe() async {
    try {
      final result = await Process.run(PathController.getExeFilePath(), []);
      return result;
    } catch (e) {
      return false;
    }
  }

  static String historyListToAhkString(
      List<DrugHistory> historyList, double speed) {
    final buffer = StringBuffer();
    const sep = '\n\n';

    List<String> ahkStringList = [];

    for (final history in historyList) {
      final String ahkString = historyToAhkString(history);
      ahkStringList.add(ahkString);
    }

    buffer.writeAll([ahkInputMode, ...ahkStringList, ahkTail(speed)], sep);

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
    Clipboard = ''';
    const String restoreClip = 'Clipboard := savedClip';

    const String tail = 'return';

    final buffer = StringBuffer();
    const sep = '\n';

    buffer.writeAll([head, backupClip, body, restoreClip, tail], sep);

    return buffer.toString();
  }

  static const String ahkInputMode = '#Hotstring SI B Z O';

  static String ahkTail(double speed) => '''print(str)    {
    Clipboard = 
    sleep, ${(60 * speed).toInt()} ;検証済み
    Clipboard = %str%
    ClipWait, 2
    sleep, ${(160 * speed).toInt()}
    send, ^v
    sleep, ${(60 * speed).toInt()}
    send, {Enter 2}
    sleep, ${(60 * speed).toInt()}
    return
}

;;IME制御の関数-------IME_SET(n)-----0で半角/1で日本語--------------------------
IME_SET(SetSts, WinTitle="A")    {
	ControlGet,hwnd,HWND,,,%WinTitle%
	if	(WinActive(WinTitle))	{
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")   ;	DWORD   cbSize;
		hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
                ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
	}
    return DllCall("SendMessage"
        , UInt, DllCall("imm32ImmGetDefaultIMEWnd", Uint,hwnd)
        , UInt, 0x0283  ;Message : WM_IME_CONTROL
        ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
        ,  Int, SetSts) ;lParam  : 0 or 1
} 

;;ctrl+Shift+Z::患者サマリ
^+z::MouseClick,LEFT,830,180 ;;患者サマリ

;;ctrl+Shift+X::処方
^+x::MouseClick,LEFT,1000,180 ;;処方

;;ctrl+Shift+C::薬歴
^+c::MouseClick,LEFT,1200,180  ;;薬歴

;;右Ctrl::薬歴確定
^+s::
    send, {Ctrl Up}
    send, {WheelUp 15}
    sleep, 500
    MouseClick,LEFT,1700,430 ;;確定（自薬局以外利用ある場合）
    MouseClick,LEFT,1700,390 ;;確定
    sleep, 500
    send, {Enter}
    sleep, 3000
    MouseClick,LEFT,530,180 ;;患者一覧（患者名6～文字）
    MouseClick,LEFT,480,180 ;;患者一覧（患者名4～5文字）
    MouseClick,LEFT,420,180 ;;患者一覧（患者名3文字）
    sleep,500
    MouseClick,LEFT,1400,420 ;;検索窓
    sleep, 500
    IME_SET(1)
    Send, {BS 8}
    return

;;Esc::患者リスト（薬歴終了）⇒患者検索
~Esc::
   MouseClick,LEFT,530,180 ;;患者一覧（患者名6～文字）
   MouseClick,LEFT,480,180 ;;患者一覧（患者名4～5文字）
   MouseClick,LEFT,420,180 ;;患者一覧（患者名3文字）
   MouseClick,LEFT,370,180 ;;患者一覧（患者名2文字）    
   sleep,200
   MouseClick,LEFT,1400,420 ;;検索窓
   sleep, 500
   Send, {BS 10}
   send, {vkF2}
   return

''';
}
