import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controllers/user_controller.dart';
import '../widgets/confirm_password_text_field.dart';
import '../widgets/email_text_field.dart';
import '../widgets/password_text_field.dart';
import '../widgets/rounded_button.dart';
import '../widgets/social_auth_buttons.dart';
import '../widgets/username_text_field.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _userHasAccount = true;
  String _passwordText;
  final UserController _controller = Get.put(UserController());
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  void _onPressed() {
    final FormBuilderState form = _fbKey.currentState;
    if (!form.saveAndValidate()) return;
    final Map<String, dynamic> value = form.value;
    final email = value['email'] as String;
    final password = value['password'] as String;
    final displayName = value['displayName'] as String;
    _userHasAccount
        ? _controller.login(email, password)
        : _controller.signup(email, displayName, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 250),
          child: FormBuilder(
            key: _fbKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(height: 60),
                const SocialAuthButtons(),
                const SizedBox(height: 50),
                EmailTextField(),
                const SizedBox(height: 30),
                Visibility(
                  visible: !_userHasAccount,
                  child: Column(
                    children: [
                      UsernameTextField(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                PasswordTextField(
                  onChange: (v) {
                    if (_userHasAccount) return;
                    setState(() => _passwordText = v as String);
                  },
                  noValidation: _userHasAccount,
                ),
                Visibility(
                  visible: !_userHasAccount,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      ConfirmPasswordTextField(match: _passwordText),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  hoverColor: const Color(0xFFFAFAFA),
                  focusColor: const Color(0xFFDBDBDB),
                  onTap: () {
                    setState(() {
                      _userHasAccount = !_userHasAccount;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _userHasAccount
                            ? "I don't have an account"
                            : "I already have an account",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 12.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      const SizedBox(width: 3.0),
                      Icon(
                        Icons.arrow_forward,
                        size: 12.0,
                        color: Colors.grey[500],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                RoundedButton(
                  text: _userHasAccount ? 'Log In' : 'Sign Up',
                  onPressed: _onPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
