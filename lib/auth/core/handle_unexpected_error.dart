import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

void handleUnexpectedError(dynamic e) {
  debugPrint('Error: $e');
  Get.snackbar(
    'Error',
    'Unexpected Error',
    snackPosition: SnackPosition.BOTTOM,
  );
}
