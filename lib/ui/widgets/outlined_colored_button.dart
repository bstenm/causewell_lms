import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OutlinedColoredButton extends StatelessWidget {
  final Color color;
  final String title;
  final String icon;
  final Function onTap;

  const OutlinedColoredButton({
    Key key,
    this.icon,
    this.title,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(width: 22.0, child: SvgPicture.asset(icon)),
            SizedBox(width: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
