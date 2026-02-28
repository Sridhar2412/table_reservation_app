// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DashboardPage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [ReservationFormPage]
class ReservationFormRoute extends PageRouteInfo<ReservationFormRouteArgs> {
  ReservationFormRoute({
    Key? key,
    ReservationModel? reservation,
    List<PageRouteInfo>? children,
  }) : super(
          ReservationFormRoute.name,
          args: ReservationFormRouteArgs(
            key: key,
            reservation: reservation,
          ),
          initialChildren: children,
        );

  static const String name = 'ReservationFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReservationFormRouteArgs>(
          orElse: () => const ReservationFormRouteArgs());
      return ReservationFormPage(
        key: args.key,
        reservation: args.reservation,
      );
    },
  );
}

class ReservationFormRouteArgs {
  const ReservationFormRouteArgs({
    this.key,
    this.reservation,
  });

  final Key? key;

  final ReservationModel? reservation;

  @override
  String toString() {
    return 'ReservationFormRouteArgs{key: $key, reservation: $reservation}';
  }
}

/// generated route for
/// [ReservationListPage]
class ReservationListRoute extends PageRouteInfo<void> {
  const ReservationListRoute({List<PageRouteInfo>? children})
      : super(
          ReservationListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReservationListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReservationListPage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}
