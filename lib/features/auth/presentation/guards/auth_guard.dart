import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_reservation_app/core/router/app_router.dart';

import '../providers/auth_providers.dart';

class AuthGuard extends AutoRouteGuard {
  final Ref ref;

  AuthGuard(this.ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authStatus = ref.read(authNotifierProvider);

    if (authStatus == AuthStatus.authenticated) {
      if (resolver.route.name == LoginRoute.name) {
        router.replaceAll([const ReservationListRoute()]);
      } else {
        resolver.next(true);
      }
    } else {
      if (resolver.route.name == LoginRoute.name) {
        resolver.next(true);
      } else {
        router.push(const LoginRoute());
      }
    }
  }
}
