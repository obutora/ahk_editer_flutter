// void main() {
//   final String s = soapToString('S', 'あいうえお');
//   final String ep = soapToString('EP', 'かきくけこ');

//   final buffer = StringBuffer();
//   const sep = '\n';

//   buffer.writeAll([s, ep], sep);

//   final String result = finalizeSoapString('@hot', buffer.toString());
//   print(result);
// }

class AhkController {
  //NOTE: FnキーによるmusubiのSOAP選択と、textBodyを生成するメソッド
  String soapToString(String soap, String text) {
    const String soap_S_Text = 'send, {F1}'; // #問
    const String soap_O_Text = 'send, {F2}';
    const String soap_A_Text = 'send, {F3}';
    const String soap_EP_Text = 'send, {F4}';
    const String soap_CP_Text = 'send, {F5}';
    const String soap_OP_Text = 'send, {F6}';

    late String headText;

    switch (soap) {
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

    final String bodyText = 'print("$text")';
    final String concat = headText + '\n' + bodyText;

    return concat;
  }

// ホットキーとreturnでbodyTextを挟むためのメソッド
  String finalizeSoapString(String hotString, String body) {
    final String head = '::$hotString::';
    const String tail = 'return';

    final buffer = StringBuffer();
    const sep = '\n';

    buffer.writeAll([head, body, tail], sep);

    return buffer.toString();
  }
}
