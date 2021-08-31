import 'package:flutter/material.dart';

class EditProfileButton extends StatelessWidget {
  final VoidCallback onClick;

  const EditProfileButton({
    Key key,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        hoverColor: const Color(0xFFfafafa),
        highlightColor: const Color(0xFFfafafa),
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Edit ',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Icon(
                Icons.edit,
                size: 17.0,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
