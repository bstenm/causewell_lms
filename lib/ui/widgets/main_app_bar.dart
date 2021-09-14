import 'package:flutter/material.dart';
import 'package:causewell/config/config.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget retry;

  @override
  final Size preferredSize;

  const MainAppBar({
    Key key,
    this.title,
    this.retry,
  })  : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(logo),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Column(
        children: <Widget>[
          Text(
            title,
            textScaleFactor: 1.0,
            style: TextStyle(color: Color(0xFFF1595C)),
          ),
          //   retry != null ? retry : Container(),
        ],
      ),
      iconTheme: IconThemeData(color: Color(0xFF8AC640)),
    );
  }
}
