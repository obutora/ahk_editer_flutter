import 'package:ahk_editor_flutter/entity/soap.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'drug_history.freezed.dart';
part 'drug_history.g.dart';

@freezed
abstract class DrugHistory with _$DrugHistory {
  // String id;
  // List<String> group;
  // String hotString;
  // List<Soap> soapList;

  const factory DrugHistory({
    required String id,
    required List<String> group,
    required String hotString,
    @SoapConverter() required List<Soap> soapList,
  }) = _DrugHistory;

  factory DrugHistory.fromJson(Map<String, dynamic> json) =>
      _$DrugHistoryFromJson(json);

  // DrugHistory copyWith({
  //   String? id,
  //   List<String>? group,
  //   String? hotString,
  //   List<Soap>? soapList,
  // }) {
  //   return DrugHistory(
  //     id: id ?? this.id,
  //     group: group ?? this.group,
  //     hotString: hotString ?? this.hotString,
  //     soapList: soapList ?? this.soapList,
  //   );
  // }

  // @override
  // String toString() {
  //   return 'DrugHistory{id: $id, group: $group, hotString: $hotString, soapList: $soapList}';
  // }
}

class SoapConverter implements JsonConverter<Soap, Object> {
  const SoapConverter();

  @override
  Soap fromJson(Object json) {
    final Map<String, dynamic> map = json as Map<String, dynamic>;
    return Soap(
      id: map['id'] as String,
      soap: map['soap'] as String,
      body: map['body'] as String,
    );
  }

  @override
  Object toJson(Soap object) => object.toJson();
}
