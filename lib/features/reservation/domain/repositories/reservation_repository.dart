import '../models/reservation_model.dart';

abstract class ReservationRepository {
  Future<List<ReservationModel>> getReservations();
  Future<ReservationModel> createReservation(ReservationModel reservation);
  Future<void> cancelReservation(String id);
  Future<void> updateReservation(ReservationModel reservation);
  Future<bool> checkAvailability(
      DateTime dateTime, int partySize, String firstName, String phone);
}
