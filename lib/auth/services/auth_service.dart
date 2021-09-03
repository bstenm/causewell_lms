import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../config/google_auth_config.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void onUserAuthenticated(Function callback) {
  _auth.authStateChanges().listen((User user) {
    if (user != null) {
      debugPrint('User is signed in!');
      callback(user);
      return;
    }
    debugPrint('User is currently signed out!');
  });
}

Future<User> signInWithGoogle() async {
  final GoogleAuthProvider googleProvider = GoogleAuthProvider();
  googleProvider.addScope('$googleAuthUrl${googleAuthScopes.join(",")}');
  googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
  // Once signed in, return the UserCredential
  final UserCredential credentials =
      await _auth.signInWithPopup(googleProvider);
  return credentials.user;
}

Future<User> signInWithFacebook() async {
  final FacebookAuthProvider facebookProvider = FacebookAuthProvider();
  facebookProvider.addScope('email');
  facebookProvider.setCustomParameters({'display': 'popup'});
  // Once signed in, return the UserCredential
  final UserCredential credentials =
      await _auth.signInWithPopup(facebookProvider);
  final User user = credentials.user;
  return user;
}

Future<User> registerUser(String email, String password) async {
  final UserCredential result =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
    password: password,
    email: email,
  );
  return result.user;
}

Future<User> loginUser(String email, String password) async {
  final UserCredential result = await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  return result.user;
}

Future<void> signoutUser() async {
  await _auth.signOut();
}

Future<void> sendPasswordResetEmail(String email) async {
  await _auth.sendPasswordResetEmail(email: email);
}

Future<void> resetPassword(String newPassword) async {
  final User user = _auth.currentUser;
  await user.updatePassword(newPassword);
}
