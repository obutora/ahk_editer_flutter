import 'package:ahk_editor_flutter/entity/drug_history.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiHandler {
  static Future<void> sendHistory(DrugHistory history) async {
    const url = 'http://sogo-vis.com:8131/add';
    final uri = Uri.parse(url);

    final json = history.toJson();
    // print(json);

    try {
      final res = await http.post(
        uri,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(json),
      );

      print('status : ${res.statusCode}\n body : ${res.body}');
    } catch (e) {
      // print(e);
    }
  }

  static Future<String> testHistory() async {
    const url = 'http://sogo-vis.com:8131/';
    final uri = Uri.parse(url);

    try {
      final res = await http.get(uri);
      return res.statusCode.toString();
    } catch (e) {
      print(e);
      return '@error';
    }
  }
}
