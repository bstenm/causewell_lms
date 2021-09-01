import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id;
  String email;
  String avatar;
  String userType;
  String location;
  String photoURL;
  String displayName;

  UserModel(
    this.id,
    this.email,
    this.displayName, {
    this.avatar,
    this.location,
    this.photoURL,
    this.userType,
  });

  Map<String, String> toJson() => {
        'id': id,
        'email': email,
        'userType': userType,
        'displayName': displayName,
      };

  factory UserModel.empty() {
    return UserModel(null, null, null);
  }

  factory UserModel.fromJson(Map<String, String> json) {
    return UserModel(
      json['id'],
      json['email'],
      json['displayName'],
      avatar: json['avatar'],
      location: json['location'],
      userType: json['userType'],
      photoURL: json['photoURL'],
    );
  }

  factory UserModel.fromAuthUser(User user) {
    return UserModel(
      user.uid,
      user.email,
      user.displayName,
      photoURL: user.photoURL,
    );
  }
}
