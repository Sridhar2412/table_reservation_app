import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/auth_repository_impl.dart';

part 'auth_providers.g.dart';

enum AuthStatus { authenticated, unauthenticated }

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthStatus build() {
    final isLoggedIn = ref.watch(authRepositoryProvider).isLoggedIn();
    return isLoggedIn ? AuthStatus.authenticated : AuthStatus.unauthenticated;
  }

  Future<bool> login(String username, String password) async {
    final success =
        await ref.read(authRepositoryProvider).login(username, password);
    if (success) {
      state = AuthStatus.authenticated;
    }
    return success;
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = AuthStatus.unauthenticated;
  }
}
