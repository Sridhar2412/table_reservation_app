import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/reservation_model.dart';
import '../models/reservation_form_state.dart';
import 'reservation_providers.dart';

part 'reservation_form_providers.g.dart';

@riverpod
class ReservationFormNotifier extends _$ReservationFormNotifier {
  @override
  ReservationFormState build() => const ReservationFormState();

  void updateDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void updateTime(TimeOfDay time) {
    state = state.copyWith(selectedTime: time);
  }

  void setInitial(ReservationModel? reservation) {
    if (reservation != null) {
      state = state.copyWith(
        selectedDate: reservation.dateTime,
        selectedTime: TimeOfDay.fromDateTime(reservation.dateTime),
      );
    }
  }

  Future<bool> checkAvailability({
    required DateTime dateTime,
    required int partySize,
    required String firstName,
    required String phone,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final isAvailable =
          await ref.read(reservationListProvider.notifier).checkAvailability(
                dateTime: dateTime,
                partySize: partySize,
                firstName: firstName,
                phone: phone,
              );
      state = state.copyWith(isLoading: false);
      return isAvailable;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }

  Future<void> submit({
    required ReservationModel reservation,
    bool isEditing = false,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      if (isEditing) {
        await ref
            .read(reservationListProvider.notifier)
            .updateReservation(reservation);
      } else {
        await ref.read(reservationListProvider.notifier).create(reservation);
      }

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        isWaitlistSuccess: reservation.status == ReservationStatus.waitlist,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}
