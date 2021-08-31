import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../config/regexes.dart';
import '../widgets/standard_text_field.dart';

class PasswordTextField extends StatefulWidget {
  final bool noValidation;
  final Function(dynamic) onChange;

  const PasswordTextField({
    Key key,
    this.onChange,
    this.noValidation,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final bool _passwordHidden = true;

  @override
  Widget build(BuildContext context) {
    return StandardTextField(
      attribute: 'password',
      labelText: 'Password',
      onChange: widget.onChange,
      obscureText: _passwordHidden,
      validators: widget.noValidation
          ? []
          : [
              FormBuilderValidators.required(errorText: 'Required'),
              FormBuilderValidators.minLength(6, errorText: 'Too short'),
              FormBuilderValidators.maxLength(15, errorText: 'Too long'),
              FormBuilderValidators.pattern(passwordRegex,
                  errorText:
                      'The password should have at least 1 capital letter, 1 number, and 1 special character'),
            ],
      // _TODO:
      //   suffix: GestureDetector(
      //     child: _passwordHidden
      //         ? SvgPicture.asset(
      //             'images/icon-eyeclosed.svg',
      //             width: 20.0,
      //             height: 20.0,
      //             semanticsLabel: 'Show password',
      //           )
      //         : SvgPicture.asset(
      //             'images/icon-eyeopened.svg',
      //             width: 20.0,
      //             height: 20.0,
      //             semanticsLabel: 'Hide password',
      //           ),
      //     onTap: () {
      //       setState(() {
      //         _passwordHidden = !_passwordHidden;
      //       });
      //     },
      //   ),
    );
  }
}
