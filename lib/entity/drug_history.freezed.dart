// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'drug_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DrugHistory _$DrugHistoryFromJson(Map<String, dynamic> json) {
  return _DrugHistory.fromJson(json);
}

/// @nodoc
mixin _$DrugHistory {
  String get id => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get date => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  List<String> get group => throw _privateConstructorUsedError;
  String get hotString => throw _privateConstructorUsedError;
  @SoapConverter()
  List<Soap> get soapList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DrugHistoryCopyWith<DrugHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrugHistoryCopyWith<$Res> {
  factory $DrugHistoryCopyWith(
          DrugHistory value, $Res Function(DrugHistory) then) =
      _$DrugHistoryCopyWithImpl<$Res>;
  $Res call(
      {String id,
      @DateTimeConverter() DateTime date,
      String author,
      List<String> group,
      String hotString,
      @SoapConverter() List<Soap> soapList});
}

/// @nodoc
class _$DrugHistoryCopyWithImpl<$Res> implements $DrugHistoryCopyWith<$Res> {
  _$DrugHistoryCopyWithImpl(this._value, this._then);

  final DrugHistory _value;
  // ignore: unused_field
  final $Res Function(DrugHistory) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
    Object? author = freezed,
    Object? group = freezed,
    Object? hotString = freezed,
    Object? soapList = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      group: group == freezed
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hotString: hotString == freezed
          ? _value.hotString
          : hotString // ignore: cast_nullable_to_non_nullable
              as String,
      soapList: soapList == freezed
          ? _value.soapList
          : soapList // ignore: cast_nullable_to_non_nullable
              as List<Soap>,
    ));
  }
}

/// @nodoc
abstract class _$$_DrugHistoryCopyWith<$Res>
    implements $DrugHistoryCopyWith<$Res> {
  factory _$$_DrugHistoryCopyWith(
          _$_DrugHistory value, $Res Function(_$_DrugHistory) then) =
      __$$_DrugHistoryCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      @DateTimeConverter() DateTime date,
      String author,
      List<String> group,
      String hotString,
      @SoapConverter() List<Soap> soapList});
}

/// @nodoc
class __$$_DrugHistoryCopyWithImpl<$Res> extends _$DrugHistoryCopyWithImpl<$Res>
    implements _$$_DrugHistoryCopyWith<$Res> {
  __$$_DrugHistoryCopyWithImpl(
      _$_DrugHistory _value, $Res Function(_$_DrugHistory) _then)
      : super(_value, (v) => _then(v as _$_DrugHistory));

  @override
  _$_DrugHistory get _value => super._value as _$_DrugHistory;

  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
    Object? author = freezed,
    Object? group = freezed,
    Object? hotString = freezed,
    Object? soapList = freezed,
  }) {
    return _then(_$_DrugHistory(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      group: group == freezed
          ? _value._group
          : group // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hotString: hotString == freezed
          ? _value.hotString
          : hotString // ignore: cast_nullable_to_non_nullable
              as String,
      soapList: soapList == freezed
          ? _value._soapList
          : soapList // ignore: cast_nullable_to_non_nullable
              as List<Soap>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DrugHistory implements _DrugHistory {
  const _$_DrugHistory(
      {required this.id,
      @DateTimeConverter() required this.date,
      this.author = "",
      required final List<String> group,
      required this.hotString,
      @SoapConverter() required final List<Soap> soapList})
      : _group = group,
        _soapList = soapList;

  factory _$_DrugHistory.fromJson(Map<String, dynamic> json) =>
      _$$_DrugHistoryFromJson(json);

  @override
  final String id;
  @override
  @DateTimeConverter()
  final DateTime date;
  @override
  @JsonKey()
  final String author;
  final List<String> _group;
  @override
  List<String> get group {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_group);
  }

  @override
  final String hotString;
  final List<Soap> _soapList;
  @override
  @SoapConverter()
  List<Soap> get soapList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_soapList);
  }

  @override
  String toString() {
    return 'DrugHistory(id: $id, date: $date, author: $author, group: $group, hotString: $hotString, soapList: $soapList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DrugHistory &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.author, author) &&
            const DeepCollectionEquality().equals(other._group, _group) &&
            const DeepCollectionEquality().equals(other.hotString, hotString) &&
            const DeepCollectionEquality().equals(other._soapList, _soapList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(author),
      const DeepCollectionEquality().hash(_group),
      const DeepCollectionEquality().hash(hotString),
      const DeepCollectionEquality().hash(_soapList));

  @JsonKey(ignore: true)
  @override
  _$$_DrugHistoryCopyWith<_$_DrugHistory> get copyWith =>
      __$$_DrugHistoryCopyWithImpl<_$_DrugHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DrugHistoryToJson(this);
  }
}

abstract class _DrugHistory implements DrugHistory {
  const factory _DrugHistory(
      {required final String id,
      @DateTimeConverter() required final DateTime date,
      final String author,
      required final List<String> group,
      required final String hotString,
      @SoapConverter() required final List<Soap> soapList}) = _$_DrugHistory;

  factory _DrugHistory.fromJson(Map<String, dynamic> json) =
      _$_DrugHistory.fromJson;

  @override
  String get id;
  @override
  @DateTimeConverter()
  DateTime get date;
  @override
  String get author;
  @override
  List<String> get group;
  @override
  String get hotString;
  @override
  @SoapConverter()
  List<Soap> get soapList;
  @override
  @JsonKey(ignore: true)
  _$$_DrugHistoryCopyWith<_$_DrugHistory> get copyWith =>
      throw _privateConstructorUsedError;
}
