import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/login_state.dart';
import 'auth_providers.dart';

part 'login_providers.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() => const LoginState();

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final success = await ref
          .read(authNotifierProvider.notifier)
          .login(username, password);

      if (success) {
        state = state.copyWith(isLoading: false, isSuccess: true);
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Invalid username or password',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void reset() {
    state = const LoginState();
  }
}
