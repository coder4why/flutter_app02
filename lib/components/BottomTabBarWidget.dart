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
              tabState().switchIndex(value);
            },
            currentIndex: tabState().tabBarIndex.value,
            type: BottomNavigationBarType.fixed,
            enableFeedback: false,
            iconSize: 28,
            items: const [
              BottomNavigationBarItem(
                  label: '首页', icon: Icon(Icons.air), tooltip: ''),
              BottomNavigationBarItem(
                  label: '电影',
                  icon: Icon(Icons.movie_filter_outlined),
                  tooltip: ''),
              BottomNavigationBarItem(
                  label: '我的',
                  icon: Icon(Icons.location_searching),
                  tooltip: ''),
            ]));
  }
}
