import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_form_state.freezed.dart';

@freezed
class ReservationFormState with _$ReservationFormState {
  const factory ReservationFormState({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool isSuccess,
    @Default(false) bool isWaitlistSuccess,
  }) = _ReservationFormState;

  const ReservationFormState._();

  DateTime? get combinedDateTime {
    if (selectedDate == null || selectedTime == null) return null;
    return DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
  }
}
