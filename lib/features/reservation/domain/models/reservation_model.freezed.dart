// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReservationModel _$ReservationModelFromJson(Map<String, dynamic> json) {
  return _ReservationModel.fromJson(json);
}

/// @nodoc
mixin _$ReservationModel {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get dateTime => throw _privateConstructorUsedError;
  int get partySize => throw _privateConstructorUsedError;
  String get tableNumber => throw _privateConstructorUsedError;
  String? get specialRequests => throw _privateConstructorUsedError;
  ReservationStatus get status => throw _privateConstructorUsedError;

  /// Serializes this ReservationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReservationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationModelCopyWith<ReservationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationModelCopyWith<$Res> {
  factory $ReservationModelCopyWith(
          ReservationModel value, $Res Function(ReservationModel) then) =
      _$ReservationModelCopyWithImpl<$Res, ReservationModel>;
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      String phone,
      @TimestampConverter() DateTime dateTime,
      int partySize,
      String tableNumber,
      String? specialRequests,
      ReservationStatus status});
}

/// @nodoc
class _$ReservationModelCopyWithImpl<$Res, $Val extends ReservationModel>
    implements $ReservationModelCopyWith<$Res> {
  _$ReservationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReservationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? dateTime = null,
    Object? partySize = null,
    Object? tableNumber = null,
    Object? specialRequests = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      partySize: null == partySize
          ? _value.partySize
          : partySize // ignore: cast_nullable_to_non_nullable
              as int,
      tableNumber: null == tableNumber
          ? _value.tableNumber
          : tableNumber // ignore: cast_nullable_to_non_nullable
              as String,
      specialRequests: freezed == specialRequests
          ? _value.specialRequests
          : specialRequests // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReservationStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationModelImplCopyWith<$Res>
    implements $ReservationModelCopyWith<$Res> {
  factory _$$ReservationModelImplCopyWith(_$ReservationModelImpl value,
          $Res Function(_$ReservationModelImpl) then) =
      __$$ReservationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      String phone,
      @TimestampConverter() DateTime dateTime,
      int partySize,
      String tableNumber,
      String? specialRequests,
      ReservationStatus status});
}

/// @nodoc
class __$$ReservationModelImplCopyWithImpl<$Res>
    extends _$ReservationModelCopyWithImpl<$Res, _$ReservationModelImpl>
    implements _$$ReservationModelImplCopyWith<$Res> {
  __$$ReservationModelImplCopyWithImpl(_$ReservationModelImpl _value,
      $Res Function(_$ReservationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReservationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? dateTime = null,
    Object? partySize = null,
    Object? tableNumber = null,
    Object? specialRequests = freezed,
    Object? status = null,
  }) {
    return _then(_$ReservationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      partySize: null == partySize
          ? _value.partySize
          : partySize // ignore: cast_nullable_to_non_nullable
              as int,
      tableNumber: null == tableNumber
          ? _value.tableNumber
          : tableNumber // ignore: cast_nullable_to_non_nullable
              as String,
      specialRequests: freezed == specialRequests
          ? _value.specialRequests
          : specialRequests // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReservationStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReservationModelImpl implements _ReservationModel {
  const _$ReservationModelImpl(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      @TimestampConverter() required this.dateTime,
      required this.partySize,
      required this.tableNumber,
      this.specialRequests,
      this.status = ReservationStatus.confirmed});

  factory _$ReservationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String phone;
  @override
  @TimestampConverter()
  final DateTime dateTime;
  @override
  final int partySize;
  @override
  final String tableNumber;
  @override
  final String? specialRequests;
  @override
  @JsonKey()
  final ReservationStatus status;

  @override
  String toString() {
    return 'ReservationModel(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, dateTime: $dateTime, partySize: $partySize, tableNumber: $tableNumber, specialRequests: $specialRequests, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.partySize, partySize) ||
                other.partySize == partySize) &&
            (identical(other.tableNumber, tableNumber) ||
                other.tableNumber == tableNumber) &&
            (identical(other.specialRequests, specialRequests) ||
                other.specialRequests == specialRequests) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, firstName, lastName, phone,
      dateTime, partySize, tableNumber, specialRequests, status);

  /// Create a copy of ReservationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationModelImplCopyWith<_$ReservationModelImpl> get copyWith =>
      __$$ReservationModelImplCopyWithImpl<_$ReservationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationModelImplToJson(
      this,
    );
  }
}

abstract class _ReservationModel implements ReservationModel {
  const factory _ReservationModel(
      {required final String id,
      required final String firstName,
      required final String lastName,
      required final String phone,
      @TimestampConverter() required final DateTime dateTime,
      required final int partySize,
      required final String tableNumber,
      final String? specialRequests,
      final ReservationStatus status}) = _$ReservationModelImpl;

  factory _ReservationModel.fromJson(Map<String, dynamic> json) =
      _$ReservationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get phone;
  @override
  @TimestampConverter()
  DateTime get dateTime;
  @override
  int get partySize;
  @override
  String get tableNumber;
  @override
  String? get specialRequests;
  @override
  ReservationStatus get status;

  /// Create a copy of ReservationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationModelImplCopyWith<_$ReservationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
