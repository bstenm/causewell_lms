import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final String pageTitle;

  final UserController _user = Get.find();

  MainLayout({
    Key key,
    this.body,
    this.pageTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.black12,
      endDrawer: Drawer(
        elevation: 0.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Row(
                children: const [
                  SizedBox(width: 5.0),
                  Text('Logout', style: TextStyle(fontSize: 17.0)),
                ],
              ),
              onTap: _user.logout,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(pageTitle),
        elevation: 0.0,
      ),
      body: body,
    );
  }
}
