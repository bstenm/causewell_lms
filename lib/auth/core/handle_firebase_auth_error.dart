import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

final authErrors = [
  'invalid-email',
  'user-not-found',
  'weak-password',
  'wrong-password',
  'email-already-in-use',
  'email-already-exists',
  'invalid-display-name',
];

void handleFirebaseAuthError(dynamic e) {
  debugPrint('Firebase Auth Error: ${e.code}');
  String message = 'Unexpected error';
  if (e.code == 'popup-closed-by-user' || e.code == 'canceled') {
    message = 'Operation cancelled';
  } else if (e.code == 'permission-denied') {
    message = 'Permission denied';
  } else if (authErrors.contains(e.code)) {
    message = e.message as String;
  }
  Get.snackbar(
    'Authentication Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
  );
}
