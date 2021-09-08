// import 'package:causewell/auth/core/handle_unexpected_error.dart';
// import 'package:causewell/data/network/api_provider.dart';
// import 'package:get/get.dart';

// class CoursesController extends GetxController {
//   final UserApiProvider _apiProvider = UserApiProvider();
//   final RxList<Map<String, dynamic>> _data = [].obs;

//   List<Map<String, dynamic>> get data => _data.value;

//   set data(List<Map<String, dynamic>> value) => _data.value = value;

//   Future<void> getAll() async {
//     try {
//       await _apiProvider.getCourses({});
//     } catch (e) {
//       handleUnexpectedError(e);
//     }
//   }
// }
