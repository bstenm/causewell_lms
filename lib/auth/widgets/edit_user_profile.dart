import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:causewell/auth/models/user_model.dart';
import 'package:causewell/auth/widgets/location_text_field.dart';
import 'package:causewell/auth/widgets/rounded_button.dart';
import 'package:causewell/auth/widgets/username_text_field.dart';

class EditUserProfile extends StatelessWidget {
  final Function save;
  final UserModel data;
  final GlobalKey<FormBuilderState> _editKey = GlobalKey<FormBuilderState>();

  EditUserProfile({
    Key key,
    this.data,
    this.save,
  }) : super(key: key);

  void onPressed() {
    final FormBuilderState form = _editKey.currentState;
    if (!form.saveAndValidate()) return;
    final Map<String, dynamic> value = form.value;
    final location = value['location'];
    final displayName = value['displayName'];
    save(location: location, displayName: displayName);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 250),
      child: FormBuilder(
        key: _editKey,
        initialValue: {
          'location': data.location,
          'displayName': data.displayName,
        },
        child: Column(
          children: [
            Text(data.email, style: const TextStyle(fontSize: 16.0)),
            const SizedBox(height: 20.0),
            UsernameTextField(),
            const SizedBox(height: 20.0),
            LocationTextField(),
            const SizedBox(height: 40),
            RoundedButton(text: 'Save', onPressed: onPressed),
          ],
        ),
      ),
    );
  }
}
