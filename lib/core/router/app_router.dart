import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/guards/auth_guard.dart';
import '../../features/auth/presentation/screens/login_page.dart';
import '../../features/auth/presentation/screens/splash_page.dart';
import '../../features/dashboard/presentation/screens/dashboard_page.dart';
import '../../features/reservation/domain/models/reservation_model.dart';
import '../../features/reservation/presentation/screens/reservation_form_page.dart';
import '../../features/reservation/presentation/screens/reservation_list_page.dart';

part 'app_router.g.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  final AuthGuard authGuard;

  AppRouter(this.authGuard);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page, guards: [authGuard]),
        AutoRoute(page: ReservationListRoute.page, guards: [authGuard]),
        AutoRoute(page: ReservationFormRoute.page, guards: [authGuard]),
        AutoRoute(page: DashboardRoute.page, guards: [authGuard]),
      ];
}

@riverpod
AuthGuard authGuard(AuthGuardRef ref) {
  return AuthGuard(ref);
}

@riverpod
AppRouter appRouter(AppRouterRef ref) {
  final guard = ref.watch(authGuardProvider);
  return AppRouter(guard);
}
