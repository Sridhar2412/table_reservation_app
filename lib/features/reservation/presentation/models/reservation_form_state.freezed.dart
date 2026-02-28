// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReservationFormState {
  DateTime? get selectedDate => throw _privateConstructorUsedError;
  TimeOfDay? get selectedTime => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  bool get isWaitlistSuccess => throw _privateConstructorUsedError;

  /// Create a copy of ReservationFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationFormStateCopyWith<ReservationFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationFormStateCopyWith<$Res> {
  factory $ReservationFormStateCopyWith(ReservationFormState value,
          $Res Function(ReservationFormState) then) =
      _$ReservationFormStateCopyWithImpl<$Res, ReservationFormState>;
  @useResult
  $Res call(
      {DateTime? selectedDate,
      TimeOfDay? selectedTime,
      bool isLoading,
      String? errorMessage,
      bool isSuccess,
      bool isWaitlistSuccess});
}

/// @nodoc
class _$ReservationFormStateCopyWithImpl<$Res,
        $Val extends ReservationFormState>
    implements $ReservationFormStateCopyWith<$Res> {
  _$ReservationFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReservationFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = freezed,
    Object? selectedTime = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isSuccess = null,
    Object? isWaitlistSuccess = null,
  }) {
    return _then(_value.copyWith(
      selectedDate: freezed == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectedTime: freezed == selectedTime
          ? _value.selectedTime
          : selectedTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      isWaitlistSuccess: null == isWaitlistSuccess
          ? _value.isWaitlistSuccess
          : isWaitlistSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationFormStateImplCopyWith<$Res>
    implements $ReservationFormStateCopyWith<$Res> {
  factory _$$ReservationFormStateImplCopyWith(_$ReservationFormStateImpl value,
          $Res Function(_$ReservationFormStateImpl) then) =
      __$$ReservationFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? selectedDate,
      TimeOfDay? selectedTime,
      bool isLoading,
      String? errorMessage,
      bool isSuccess,
      bool isWaitlistSuccess});
}

/// @nodoc
class __$$ReservationFormStateImplCopyWithImpl<$Res>
    extends _$ReservationFormStateCopyWithImpl<$Res, _$ReservationFormStateImpl>
    implements _$$ReservationFormStateImplCopyWith<$Res> {
  __$$ReservationFormStateImplCopyWithImpl(_$ReservationFormStateImpl _value,
      $Res Function(_$ReservationFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReservationFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = freezed,
    Object? selectedTime = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isSuccess = null,
    Object? isWaitlistSuccess = null,
  }) {
    return _then(_$ReservationFormStateImpl(
      selectedDate: freezed == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectedTime: freezed == selectedTime
          ? _value.selectedTime
          : selectedTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      isWaitlistSuccess: null == isWaitlistSuccess
          ? _value.isWaitlistSuccess
          : isWaitlistSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ReservationFormStateImpl extends _ReservationFormState {
  const _$ReservationFormStateImpl(
      {this.selectedDate,
      this.selectedTime,
      this.isLoading = false,
      this.errorMessage,
      this.isSuccess = false,
      this.isWaitlistSuccess = false})
      : super._();

  @override
  final DateTime? selectedDate;
  @override
  final TimeOfDay? selectedTime;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  @JsonKey()
  final bool isWaitlistSuccess;

  @override
  String toString() {
    return 'ReservationFormState(selectedDate: $selectedDate, selectedTime: $selectedTime, isLoading: $isLoading, errorMessage: $errorMessage, isSuccess: $isSuccess, isWaitlistSuccess: $isWaitlistSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationFormStateImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.selectedTime, selectedTime) ||
                other.selectedTime == selectedTime) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.isWaitlistSuccess, isWaitlistSuccess) ||
                other.isWaitlistSuccess == isWaitlistSuccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate, selectedTime,
      isLoading, errorMessage, isSuccess, isWaitlistSuccess);

  /// Create a copy of ReservationFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationFormStateImplCopyWith<_$ReservationFormStateImpl>
      get copyWith =>
          __$$ReservationFormStateImplCopyWithImpl<_$ReservationFormStateImpl>(
              this, _$identity);
}

abstract class _ReservationFormState extends ReservationFormState {
  const factory _ReservationFormState(
      {final DateTime? selectedDate,
      final TimeOfDay? selectedTime,
      final bool isLoading,
      final String? errorMessage,
      final bool isSuccess,
      final bool isWaitlistSuccess}) = _$ReservationFormStateImpl;
  const _ReservationFormState._() : super._();

  @override
  DateTime? get selectedDate;
  @override
  TimeOfDay? get selectedTime;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  bool get isSuccess;
  @override
  bool get isWaitlistSuccess;

  /// Create a copy of ReservationFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationFormStateImplCopyWith<_$ReservationFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
