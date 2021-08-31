import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../widgets/standard_text_field.dart';

class EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StandardTextField(
      attribute: "email",
      labelText: 'Email',
      validators: [
        FormBuilderValidators.email(),
        FormBuilderValidators.required(),
      ],
    );
  }
}
