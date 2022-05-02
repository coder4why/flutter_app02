// ignore: file_names
import 'package:flutter/material.dart';

class BottomTabBarWidget extends StatefulWidget {
  final Function tapSwitch;
  const BottomTabBarWidget(
    this.tapSwitch, {
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return BottomTabBarContentWidget();
  }
}

class BottomTabBarContentWidget extends State<StatefulWidget> {
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (value) {
          BottomTabBarWidget tabBarWidget =
              context.widget as BottomTabBarWidget;
          tabBarWidget.tapSwitch(value);
          setState(() {
            selectIndex = value;
          });
        },
        currentIndex: selectIndex,
        // selectedItemColor: Colors.orange,
        // unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        enableFeedback: false,
        iconSize: 28,
        items: const [
          BottomNavigationBarItem(label: '首页', icon: Icon(Icons.air)),
          BottomNavigationBarItem(label: '听说', icon: Icon(Icons.mic)),
          BottomNavigationBarItem(
              label: '我的', icon: Icon(Icons.location_searching)),
        ]);
  }
}
