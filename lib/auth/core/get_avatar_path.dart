import '../config/config.dart';

String getAvatarPath(String uid) {
  return '$avatarStorageFolder/avatar_${uid}_${DateTime.now()}';
}
