// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DrugHistory _$$_DrugHistoryFromJson(Map<String, dynamic> json) =>
    _$_DrugHistory(
      id: json['id'] as String,
      group: (json['group'] as List<dynamic>).map((e) => e as String).toList(),
      hotString: json['hotString'] as String,
      soapList: (json['soapList'] as List<dynamic>)
          .map((e) => const SoapConverter().fromJson(e as Object))
          .toList(),
    );

Map<String, dynamic> _$$_DrugHistoryToJson(_$_DrugHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group': instance.group,
      'hotString': instance.hotString,
      'soapList': instance.soapList.map(const SoapConverter().toJson).toList(),
    };
