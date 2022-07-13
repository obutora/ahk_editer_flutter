import 'package:ahk_editor_flutter/entity/soap.dart';

class DrugHistory {
  String id;
  List<String> group;
  String hotString;
  List<Soap> soapList;

  DrugHistory({
    required this.id,
    required this.group,
    required this.hotString,
    required this.soapList,
  });

  DrugHistory copyWith({
    String? id,
    List<String>? group,
    String? hotString,
    List<Soap>? soapList,
  }) {
    return DrugHistory(
      id: id ?? this.id,
      group: group ?? this.group,
      hotString: hotString ?? this.hotString,
      soapList: soapList ?? this.soapList,
    );
  }

  @override
  String toString() {
    return 'DrugHistory{id: $id, group: $group, hotString: $hotString, soapList: $soapList}';
  }
}
