import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _store = FirebaseFirestore.instance;
final CollectionReference _users = _store.collection('users');

Future<Map<String, dynamic>> getUserFromDb(String uid) async {
  final DocumentSnapshot doc = await _users.doc(uid).get();
  return doc.data();
}

Future<void> saveUserToDb(
  String uid,
  Map<String, dynamic> data,
) async {
  await _users.doc(uid).set(data);
}

Future<void> updateAvatarInDb(
  String uid,
  String avatar,
) async {
  await _users.doc(uid).update({'avatar': avatar});
}

Future<void> updateUserDataInDb(
  String uid, {
  String location,
  String displayName,
}) async {
  await _users.doc(uid).update({
    'location': location,
    'displayName': displayName,
  });
}
