import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import './standard_text_field.dart';

class UsernameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StandardTextField(
      labelText: 'Username',
      attribute: "displayName",
      validators: [
        FormBuilderValidators.minLength(2),
        FormBuilderValidators.maxLength(30),
        FormBuilderValidators.required(),
      ],
    );
  }
}
