import 'package:flutter/material.dart';
import 'package:causewell/auth/config/config.dart';

class UserAvatar extends StatelessWidget {
  final String avatar;
  final Function onClick;

  const UserAvatar({
    Key key,
    this.avatar,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onClick != null) onClick();
      },
      child: CircleAvatar(
        radius: 40.0,
        backgroundImage: NetworkImage(avatar ?? avatarPlaceholder),
      ),
    );
  }
}
