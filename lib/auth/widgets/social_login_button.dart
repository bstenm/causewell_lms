import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    Key key,
    @required this.icon,
    @required this.login,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback login;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: const CircleBorder(),
      onPressed: login,
      child: icon,
    );
  }
}
