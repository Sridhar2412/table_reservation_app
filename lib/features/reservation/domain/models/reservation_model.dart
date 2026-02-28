import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/converters/timestamp_converter.dart';

part 'reservation_model.freezed.dart';
part 'reservation_model.g.dart';

enum ReservationStatus {
  confirmed,
  cancelled,
  waitlist,
}

@freezed
class ReservationModel with _$ReservationModel {
  const factory ReservationModel({
    required String id,
    required String firstName,
    required String lastName,
    required String phone,
    @TimestampConverter() required DateTime dateTime,
    required int partySize,
    required String tableNumber,
    String? specialRequests,
    @Default(ReservationStatus.confirmed) ReservationStatus status,
  }) = _ReservationModel;

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationModelFromJson(json);
}
