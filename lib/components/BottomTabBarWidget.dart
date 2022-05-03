// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../tool/global_config.dart';

class BottomTabBarWidget extends StatefulWidget {
  const BottomTabBarWidget({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return BottomTabBarContentWidget();
  }
}

class BottomTabBarContentWidget extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
            onTap: (value) {
              appState().switchIndex(value);
            },
            currentIndex: appState().tabBarIndex.value,
            type: BottomNavigationBarType.fixed,
            enableFeedback: false,
            selectedFontSize: 13,
            unselectedFontSize: 13,
            iconSize: 28,
            items: [
              renderItem(0),
              renderItem(1),
              renderItem(2),
            ]));
  }
}

BottomNavigationBarItem renderItem(index) {
  return BottomNavigationBarItem(
      label: GlobalConfig.tabZwTitles[index],
      icon: Icon(GlobalConfig.tabIcons[index]),
      tooltip: '');
}
