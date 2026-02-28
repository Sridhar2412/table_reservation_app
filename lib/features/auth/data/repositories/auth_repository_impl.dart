import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_repository_impl.g.dart';

abstract class AuthRepository {
  Future<bool> login(String username, String password);
  Future<void> logout();
  bool isLoggedIn();
}

class AuthRepositoryImpl implements AuthRepository {
  final SharedPreferences _prefs;
  static const String _isLoggedInKey = 'isLoggedIn';

  AuthRepositoryImpl(this._prefs);

  @override
  Future<bool> login(String username, String password) async {
    if (username == 'admin' && password == 'admin') {
      await _prefs.setBool(_isLoggedInKey, true);
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    await _prefs.setBool(_isLoggedInKey, false);
  }

  @override
  bool isLoggedIn() {
    return _prefs.getBool(_isLoggedInKey) ?? false;
  }
}

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthRepositoryImpl(prefs);
}
