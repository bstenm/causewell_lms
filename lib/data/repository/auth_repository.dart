import 'package:causewell/auth/services/auth_service.dart';
import 'package:inject/inject.dart';
import 'package:causewell/data/cache/cache_manager.dart';
import 'package:causewell/data/models/auth.dart';
import 'package:causewell/data/network/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRepository {
  Future authUser(String login, String password);

  Future register(String login, String email, String password);

  Future restorePassword(String email);

  Future demoAuth();

  Future<String> getToken();

  Future<bool> isSigned();

  Future logout();
}

@provide
@singleton
class AuthRepositoryImpl extends AuthRepository {
  final UserApiProvider provider;
  final SharedPreferences _sharedPreferences;
  static const tokenKey = "apiToken";

  AuthRepositoryImpl(this.provider, this._sharedPreferences);

  @override
  Future authUser(String login, String password) async {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $login, $password');
    AuthResponse response = await provider.authUser(login, password);
    // ADDED
    await loginUser(login, password);
    _saveToken(response.token);
  }

  @override
  Future register(String login, String email, String password) async {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $email, $password');
    AuthResponse response = await provider.signUpUser(login, email, password);
    // ADDED
    await registerUser(email, password);
    _saveToken(response.token);
  }

  @override
  Future<String> getToken() {
    return Future.value(_sharedPreferences.getString(tokenKey));
  }

  void _saveToken(String token) {
    _sharedPreferences.setString(tokenKey, token);
  }

  @override
  Future<bool> isSigned() {
    var token = _sharedPreferences.getString(tokenKey);
    if (token != null && token.isNotEmpty) return Future.value(true);
    return Future.value(false);
  }

  @override
  Future logout() async {
    _sharedPreferences.setString("apiToken", "");
    await CacheManager().cleanCache();
  }

  @override
  Future demoAuth() async {
    var token = await provider.demoAuth();
    _saveToken(token);
  }

  @override
  Future restorePassword(String email) async {
    await provider.restorePassword(email);
  }
}
