import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/reservation_model.dart';
import '../../domain/repositories/reservation_repository.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final FirebaseFirestore _firestore;

  ReservationRepositoryImpl(this._firestore);

  CollectionReference get _reservationsRef =>
      _firestore.collection('reservations');

  @override
  Future<List<ReservationModel>> getReservations() async {
    final snapshot = await _reservationsRef.get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final id = doc.id;

      DateTime parsedDateTime;
      if (data['dateTime'] is Timestamp) {
        parsedDateTime = (data['dateTime'] as Timestamp).toDate();
      } else {
        parsedDateTime =
            DateTime.tryParse(data['dateTime']?.toString() ?? '') ??
                DateTime.now();
      }

      return ReservationModel(
        id: id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        phone: data['phone'] ?? '',
        dateTime: parsedDateTime,
        partySize: data['partySize'] ?? 1,
        tableNumber: data['tableNumber'] ?? '1',
        specialRequests: data['specialRequests'],
        status: _mapStatus(data['status']),
      );
    }).toList();
  }

  @override
  Future<ReservationModel> createReservation(ReservationModel entity) async {
    final docRef = _reservationsRef.doc();
    final apiReservation = _toMap(entity);
    await docRef.set(apiReservation);
    return entity.copyWith(id: docRef.id);
  }

  @override
  Future<void> cancelReservation(String id) async {
    await _reservationsRef.doc(id).update({
      'status': 'Cancelled',
    });
  }

  @override
  Future<void> updateReservation(ReservationModel reservation) async {
    final apiReservation = _toMap(reservation);
    await _reservationsRef.doc(reservation.id).update(apiReservation);
  }

  @override
  Future<bool> checkAvailability(
      DateTime dateTime, int partySize, String firstName, String phone) async {
    const totalTables = 20;
    final reservations = await getReservations();

    final isDuplicate = reservations.any((r) =>
        r.firstName.toLowerCase() == firstName.toLowerCase() &&
        r.phone == phone &&
        r.dateTime.year == dateTime.year &&
        r.dateTime.month == dateTime.month &&
        r.dateTime.day == dateTime.day &&
        r.dateTime.hour == dateTime.hour &&
        r.dateTime.minute == dateTime.minute &&
        r.status != ReservationStatus.cancelled);

    if (isDuplicate) return false;

    int overlappingCount = 0;

    for (var r in reservations) {
      if (r.status == ReservationStatus.cancelled ||
          r.status == ReservationStatus.waitlist) continue;

      final diff = r.dateTime.difference(dateTime).inMinutes.abs();
      if (diff < 120) {
        overlappingCount++;
      }
    }

    return (overlappingCount + 1) <= totalTables;
  }

  ReservationStatus _mapStatus(String? status) {
    if (status == 'Cancelled') return ReservationStatus.cancelled;
    if (status == 'Waitlist') return ReservationStatus.waitlist;
    return ReservationStatus.confirmed;
  }

  Map<String, dynamic> _toMap(ReservationModel data) {
    String statusStr = 'Confirmed';
    if (data.status == ReservationStatus.cancelled)
      statusStr = 'Cancelled';
    else if (data.status == ReservationStatus.waitlist) statusStr = 'Waitlist';

    return {
      'firstName': data.firstName,
      'lastName': data.lastName,
      'phone': data.phone,
      'dateTime': data.dateTime.toUtc().toIso8601String(),
      'partySize': data.partySize,
      'tableNumber': data.tableNumber,
      'specialRequests': data.specialRequests,
      'status': statusStr,
    };
  }
}
