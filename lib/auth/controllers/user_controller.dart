import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../core/get_avatar_path.dart';
import '../core/handle_firebase_auth_error.dart';
import '../core/handle_unexpected_error.dart';
import '../core/social_media.dart';
import '../core/user_status.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';

class UserController extends GetxController {
  final RxBool _editMode = false.obs;
  final Rx<UserModel> _data = UserModel.empty().obs;
  final Rx<UserStatus> _status = UserStatus.signedOut.obs;

  bool get editMode => _editMode.value;
  UserModel get data => _data.value;
  UserStatus get status => _status.value;

  set data(UserModel value) => _data.value = value;
  set status(UserStatus value) => _status.value = value;
  set editMode(bool value) => _editMode.value = value;

  @override
  void onInit() {
    onUserAuthenticated(onAuthenticated);
    super.onInit();
  }

  void setEditMode() {
    editMode = !_editMode.value;
  }

  Future<void> editProfile({String location, String displayName}) async {
    await updateUserDataInDb(
      data.id,
      location: location ?? data.location,
      displayName: displayName ?? data.displayName,
    );
    data.location = location;
    data.displayName = displayName;
    setEditMode();
  }

  Future<void> onAuthenticated(User authUser) async {
    try {
      final String uid = authUser.uid;
      final result = await getUserFromDb(uid) as Map<String, String>;
      if (result == null) {
        debugPrint('>> Saving user to database');
        final UserModel authData = UserModel.fromAuthUser(authUser);
        await saveUserToDb(uid, authData.toJson());
        status = UserStatus.signedIn;
        data = authData;
        return;
      }
      status = UserStatus.signedIn;
      data = UserModel.fromJson(result);
    } catch (e) {
      handleUnexpectedError(e);
    }
  }

  Future<void> socialMediaSignIn(SocialMedia authProvider) async {
    try {
      // Sign in with corresponding social media
      await {
        SocialMedia.google: signInWithGoogle,
        SocialMedia.facebook: signInWithFacebook,
      }[authProvider]();
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
    } catch (e) {
      handleUnexpectedError(e);
    }
  }

  Future<void> signup(String email, String displayName, String password) async {
    try {
      final User authUser = await registerUser(email, password);
      final UserModel authData = UserModel.fromAuthUser(authUser);
      authData.displayName = displayName;
      await saveUserToDb(authData.id, authData.toJson());
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
    } catch (e) {
      handleUnexpectedError(e);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await loginUser(email, password);
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
    } catch (e) {
      handleUnexpectedError(e);
    }
  }

  Future<void> logout() async {
    try {
      await signoutUser();
      status = UserStatus.signedOut;
      data = UserModel.empty();
    } catch (e) {
      handleUnexpectedError(e);
    }
  }

  Future uploadAvatar() async {
//     try {
//       final String uid = data.id;
//       const ImageSource source = ImageSource.gallery;
//       // Open dialog box to pick image from computer
//       final pickedFile = await ImagePicker().getImage(source: source);
//       // Get the picked image raw data
//       final Uint8List bytes = await pickedFile.readAsBytes();
//       // Save the file into the storage
//       final String fileRef = getAvatarPath(uid);
//       final Reference storageRef = FirebaseStorage.instance.ref(fileRef);
//       await storageRef.putData(bytes);
//       // Get the url to the user avatar
//       final String avatar = await storageRef.getDownloadURL();
//       // Update the user's avatar in the database
//       await updateAvatarInDb(uid, avatar);
//       // Update the state
//       _data.update((u) => u.avatar = avatar);
//     } on FirebaseException catch (e) {
//       debugPrint('Firebase Exception $e');
//       handleFirebaseAuthError(e);
//     } catch (e) {
//       debugPrint('Exception $e');
//       handleUnexpectedError(e);
//     }
  }
}
