// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reservationRepositoryHash() =>
    r'890d8d7e47041c555416131859bee5303826c928';

/// See also [reservationRepository].
@ProviderFor(reservationRepository)
final reservationRepositoryProvider =
    AutoDisposeProvider<ReservationRepository>.internal(
  reservationRepository,
  name: r'reservationRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reservationRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReservationRepositoryRef
    = AutoDisposeProviderRef<ReservationRepository>;
String _$reservationListHash() => r'7fd54048020b0027d326cd453fcbed201bcd8106';

/// See also [ReservationList].
@ProviderFor(ReservationList)
final reservationListProvider = AutoDisposeAsyncNotifierProvider<
    ReservationList, List<ReservationModel>>.internal(
  ReservationList.new,
  name: r'reservationListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reservationListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReservationList = AutoDisposeAsyncNotifier<List<ReservationModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
