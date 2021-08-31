import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../controllers/user_controller.dart';
import '../core/social_media.dart';
import '../widgets/social_login_button.dart';

class SocialAuthButtons extends GetView<UserController> {
  const SocialAuthButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SocialAuthButton(
            login: () => controller.socialMediaSignIn(SocialMedia.google),
            icon: SizedBox(
              width: 28,
              child: Image.asset(
                'images/google-logo.jpeg',
                semanticLabel: 'Google login',
              ),
            ),
          ),
          SocialAuthButton(
            login: () => controller.socialMediaSignIn(SocialMedia.facebook),
            icon: SizedBox(
              width: 25,
              child: Image.asset(
                'images/facebook-logo-round.png',
                semanticLabel: 'Facebook login',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
