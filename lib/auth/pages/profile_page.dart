import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controllers/user_controller.dart';
import '../widgets/cancel_edit_profile_button.dart';
import '../widgets/edit_profile_button.dart';
import '../widgets/edit_user_profile.dart';
import '../widgets/main_layout.dart';
import '../widgets/user_avatar.dart';
import '../widgets/user_profile.dart';

class ProfilePage extends StatelessWidget {
  final UserController _user = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pageTitle: 'Profile',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30.0),
            Obx(
              () => _user.data.avatar == null
                  ? const CircularProgressIndicator()
                  : UserAvatar(
                      avatar: _user.data.avatar ?? _user.data.photoURL,
                      onClick: _user.uploadAvatar,
                    ),
            ),
            const SizedBox(height: 30.0),
            Obx(() => !_user.editMode
                ? EditProfileButton(onClick: _user.setEditMode)
                : CancelEditProfileButton(onClick: _user.setEditMode)),
            const SizedBox(height: 20.0),
            Obx(
              () => !_user.editMode
                  ? UserProfile(data: _user.data)
                  : EditUserProfile(
                      data: _user.data,
                      save: _user.editProfile,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
