import 'package:ahk_editor_flutter/provider/editing_history_provider.dart';

class Soap {
  final String id = uuid.v4();
  final String soap; //S, O, A, EP, OP, CP
  final String body;

  Soap({required this.soap, required this.body});

  @override
  String toString() => 'Soap{soap: $soap, body: $body}';
}

const SoapLabels = [
  'S',
  'O',
  'A',
  'EP',
  'OP',
  'CP',
];
