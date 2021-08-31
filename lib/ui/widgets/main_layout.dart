import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:causewell/main.dart';

class MainLayout extends StatefulWidget {
  final Widget body;

  const MainLayout({this.body}) : super();

  @override
  State<StatefulWidget> createState() {
    return MainLayoutState();
  }
}

class MainLayoutState extends State<MainLayout> {
  String token;
  var _selectedIndex = 0;
  final _selectedItemColor = mainColor;
  final _unselectedItemColor = Colors.white;
//   final _selectedBgColor = Colors.white;
//   final _unselectedBgColor = Colors.white;
//   final _unselectedBgColor = mainColor;

  Color _getBgColor(int index) => [
        Color(0xFFF1595C),
        Color(0xFFFFCC1E),
        Color(0xFF8AC640),
        Color(0xFF2BC3EB),
        Color(0xFF094DAF),
      ][index];
  //   _selectedIndex == index ? _selectedBgColor : _unselectedBgColor;

  Color _getItemColor(int index) => _unselectedItemColor;
  //   _selectedIndex == index ? _selectedItemColor : _unselectedItemColor;

  Widget _buildIcon(String iconData, String text, int index) => Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Material(
          //   color: _getBgColor(index),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Icon(iconData),
                Padding(
                  padding: EdgeInsets.only(top: 2.0, bottom: 4.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: _getBgColor(index),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SvgPicture.asset(iconData,
                        height: 22.0, color: _getItemColor(index)),
                  ),
                ),
                // Text(text,
                //     textScaleFactor: 1.0,
                //     style:
                //         TextStyle(fontSize: 12, color: _getItemColor(index))),
              ],
            ),
            onTap: () => _onItemTapped(index),
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: _buildIcon("assets/icons/ms_nav_home.svg",
                  localizations.getLocalization("home_bottom_nav"), 0),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: _buildIcon("assets/icons/ms_nav_courses.svg",
                  localizations.getLocalization("courses_bottom_nav"), 1),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: _buildIcon("assets/icons/ms_nav_search.svg",
                  localizations.getLocalization("search_bottom_nav"), 2),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: _buildIcon("assets/icons/ms_nav_fav.svg",
                  localizations.getLocalization("favorites_bottom_nav"), 3),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: _buildIcon("assets/icons/ms_nav_profile.svg",
                  localizations.getLocalization("profile_bottom_nav"), 4),
              title: SizedBox.shrink()),
        ],
        selectedFontSize: 0,
        currentIndex: _selectedIndex,
        selectedItemColor: _selectedItemColor,
        unselectedItemColor: _unselectedItemColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
