import 'package:causewell/auth/controllers/user_controller.dart';
import 'package:causewell/auth/core/handle_firebase_auth_error.dart';
import 'package:causewell/auth/core/handle_unexpected_error.dart';
import 'package:causewell/auth/models/user_model.dart';
import 'package:causewell/auth/services/auth_service.dart';
import 'package:causewell/auth/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:inject/inject.dart';
import 'package:causewell/data/cache/cache_manager.dart';
import 'package:causewell/data/models/auth.dart';
import 'package:causewell/data/network/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRepository {
  final userController = Get.find<UserController>();

  Future authUser(String userType, String login, String password);

  Future register(String userType, String login, String email, String password);

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
// REMOVED
//   @override
//   Future authUser(String userType, String email, String password) async {
//     AuthResponse response = await provider.authUser(login, password);
//     _saveToken(response.token);
//   }

// ADDED
  @override
  Future authUser(String userType, String email, String password) async {
    try {
      final token = await provider.demoAuth();
      final User userData = await loginUser(email, password);
      userController.data = UserModel.fromAuthUser(userData);
      _saveToken(token);
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
    } catch (e) {
      handleUnexpectedError(e);
    }
  }

// REMOVED
//   @override
//   Future register(
//       String userType, String login, String email, String password) async {
//     AuthResponse response = await provider.signUpUser(login, email, password);
//     _saveToken(response.token);
//   }

// ADDED
  @override
  Future<void> register(String userType, String displayName, String email,
      String password) async {
    final User authUser = await registerUser(email, password);
    final UserModel authData = UserModel.fromAuthUser(authUser);
    authData.userType = userType;
    authData.displayName = displayName;
    await saveUserToDb(authData.id, authData.toJson());
    userController.data = authData;
    final token = await provider.demoAuth();
    _saveToken(token);
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
