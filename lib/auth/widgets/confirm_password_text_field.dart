import 'package:flutter/material.dart';
import '../widgets/standard_text_field.dart';

class ConfirmPasswordTextField extends StatelessWidget {
  final String match;

  const ConfirmPasswordTextField({
    Key key,
    this.match,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardTextField(
      attribute: 'confirm_password',
      labelText: 'Confirm Password',
      obscureText: true,
      validators: [
        (val) {
          return val != match ? "The passwords don't match" : null;
        },
      ],
    );
  }
}
