import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import './standard_text_field.dart';

class LocationTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StandardTextField(
      labelText: 'Location',
      attribute: "location",
      validators: [
        FormBuilderValidators.maxLength(50),
        (val) {
          return (val != '' && (val as String).length < 5) ? 'Too short' : null;
        }
      ],
    );
  }
}
