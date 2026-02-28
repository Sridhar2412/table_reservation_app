import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/reservation_repository_impl.dart';
import '../../domain/models/reservation_model.dart';
import '../../domain/repositories/reservation_repository.dart';

part 'reservation_providers.g.dart';

@riverpod
ReservationRepository reservationRepository(ReservationRepositoryRef ref) {
  return ReservationRepositoryImpl(FirebaseFirestore.instance);
}

@riverpod
class ReservationList extends _$ReservationList {
  late ReservationRepository _repo;

  @override
  FutureOr<List<ReservationModel>> build() async {
    _repo = ref.read(reservationRepositoryProvider);
    return _fetchReservations();
  }

  Future<List<ReservationModel>> _fetchReservations() async {
    final result = await _repo.getReservations();
    final items = List<ReservationModel>.from(result);
    items.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return items;
  }

  Future<void> create(ReservationModel entity) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.createReservation(entity);
      return _fetchReservations();
    });
  }

  Future<void> cancel(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.cancelReservation(id);
      return _fetchReservations();
    });
  }

  Future<void> updateReservation(ReservationModel entity) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.updateReservation(entity);
      return _fetchReservations();
    });
  }

  Future<bool> checkAvailability({
    required DateTime dateTime,
    required int partySize,
    required String firstName,
    required String phone,
  }) async {
    return await _repo.checkAvailability(dateTime, partySize, firstName, phone);
  }
}
