import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class StandardTextField extends StatefulWidget {
  final bool obscureText;
  final Widget suffix;
  final String attribute;
  final String labelText;
  final Function(dynamic) onChange;
  final TextEditingController controller;
  final List<String Function(dynamic)> validators;

  const StandardTextField({
    Key key,
    this.suffix,
    this.controller,
    this.validators,
    this.onChange,
    this.obscureText = false,
    @required this.attribute,
    @required this.labelText,
  }) : super(key: key);

  @override
  _StandardTextFieldState createState() => _StandardTextFieldState();
}

class _StandardTextFieldState extends State<StandardTextField> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      attribute: widget.attribute,
      controller: widget.controller,
      onChanged: widget.onChange,
      obscureText: widget.obscureText,
      // -- Decoration
      decoration: InputDecoration(
        suffix: widget.suffix,
        isDense: true,
        filled: true,
        hoverColor: const Color(0xffF7F8FA),
        fillColor: const Color(0xffF7F8FA),
        hintStyle: const TextStyle(
          color: Color(0xff94A6B1),
          fontSize: 14,
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Color(0xff94A6B1),
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xffD6DDE2)),
        ),
        // -- Eabled border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xffD6DDE2)),
        ),
        // -- Focused border
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xff0D8AF4)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validators: widget.validators,
    );
  }
}
