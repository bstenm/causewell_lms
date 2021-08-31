import 'package:flutter/material.dart';
import 'package:causewell/auth/models/user_model.dart';

class UserProfile extends StatelessWidget {
  final UserModel data;

  const UserProfile({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          data.email,
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 20.0),
        Text(
          data.displayName,
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 20.0),
        Visibility(
          visible: data.location != null,
          child: Text(
            data.location ?? '',
            style: const TextStyle(fontSize: 16.0),
          ),
        )
      ],
    );
  }
}
