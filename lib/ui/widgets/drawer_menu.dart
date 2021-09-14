import 'package:causewell/auth/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import 'outlined_colored_button.dart';
import '../screen/main/main_screen.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

final String defaultAvatar = 'assets/images/default-avatar.png';

class DrawerMenu extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  final Function exploreCallback;

  static const routeName = "menuScreen";
  DrawerMenu({this.exploreCallback}) : super();

  final _space = () => SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    final userData = userController.data;

    onTap(index) {
      Navigator.pushReplacementNamed(
        context,
        MainScreen.routeName,
        arguments: MainScreenArgs(null, selectedIndex: index),
      );
    }

    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.white,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(userData.photoURL ?? defaultAvatar),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (userData.displayName != null)
                    Text(capitalize(userData.displayName),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        )),
                  SizedBox(height: 20.0),
                  if (userData.email != null)
                    Text(
                      userData.email,
                      style: TextStyle(fontSize: 15),
                    ),
                ],
              ),
            ],
          ),
          _space(),
          _space(),
          OutlinedColoredButton(
              icon: searchIcon,
              title: 'Explore',
              color: const Color(0xFF8AC640),
              onTap: () => onTap(2)),
          _space(),
          OutlinedColoredButton(
            icon: performanceIcon,
            title: 'Courses',
            color: const Color(0xFFFFCC1E),
            onTap: () => onTap(0),
          ),
          _space(),
          OutlinedColoredButton(
              icon: learnIcon,
              title: 'Learn',
              color: const Color(0xFFF1595C),
              onTap: () => onTap(1)),
          _space(),
          OutlinedColoredButton(
              icon: favoritesIcon,
              title: 'Favorites',
              color: const Color(0xFF2BC3EB),
              onTap: () => onTap(3)),
          //   _space(),
          //   OutlinedColoredButton(
          //     icon: quizzesIcon,
          //     title: 'Quizzes',
          //     color: const Color(0xFF094DAF),
          //   ),
          //   _space(),
          //   OutlinedColoredButton(
          //     icon: surveyIcon,
          //     title: 'Surveys',
          //     color: const Color(0xFFF1595C),
          //   ),
          //   _space(),
          //   OutlinedColoredButton(
          //     icon: exercicesIcon,
          //     title: 'Exercises',
          //     color: const Color(0xFF8AC640),
          //   ),
          //   _space(),
          //   OutlinedColoredButton(
          //     icon: chatIcon,
          //     title: 'Chats',
          //     color: const Color(0xFF2BC3EB),
          //   ),
          _space(),
          OutlinedColoredButton(
              icon: settingsIcon,
              title: 'Settings',
              color: const Color(0xFFFFCC1E),
              onTap: () => {onTap(4)}),
        ],
      ),
    );
  }
}
