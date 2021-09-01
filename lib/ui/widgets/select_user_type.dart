import 'package:flutter/material.dart';

class SelectUserType extends StatelessWidget {
  final String type;
  final Function onChanged;

  const SelectUserType({
    Key key,
    this.type,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 'student',
                groupValue: type,
                onChanged: onChanged,
              ),
              Text(
                'Student',
                style: TextStyle(fontSize: 16.0),
              ),
              Radio(
                value: 'Instructor',
                groupValue: type,
                onChanged: onChanged,
              ),
              Text(
                'Instructor',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
