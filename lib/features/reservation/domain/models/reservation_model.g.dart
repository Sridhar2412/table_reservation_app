// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationModelImpl _$$ReservationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ReservationModelImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
      dateTime: const TimestampConverter().fromJson(json['dateTime']),
      partySize: (json['partySize'] as num).toInt(),
      tableNumber: json['tableNumber'] as String,
      specialRequests: json['specialRequests'] as String?,
      status: $enumDecodeNullable(_$ReservationStatusEnumMap, json['status']) ??
          ReservationStatus.confirmed,
    );

Map<String, dynamic> _$$ReservationModelImplToJson(
        _$ReservationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'dateTime': const TimestampConverter().toJson(instance.dateTime),
      'partySize': instance.partySize,
      'tableNumber': instance.tableNumber,
      'specialRequests': instance.specialRequests,
      'status': _$ReservationStatusEnumMap[instance.status]!,
    };

const _$ReservationStatusEnumMap = {
  ReservationStatus.confirmed: 'confirmed',
  ReservationStatus.cancelled: 'cancelled',
  ReservationStatus.waitlist: 'waitlist',
};
