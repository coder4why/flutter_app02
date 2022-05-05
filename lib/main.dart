import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'components/BottomTabBarWidget.dart';
import 'components/MainDrawer.dart';
import 'pages/movie/MoviePage.dart';
import 'pages/music/MusicPage.dart';
import 'pages/personal/PersonalPage.dart';
import 'tool/global_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: const HomeWidget(), theme: Themes.pink);
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HomeStateWidget();
  }
}

class HomeStateWidget extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Obx(() => Scaffold(
              appBar: appState().tabBarIndex.value == 0
                  ? null
                  : AppBar(
                      title: IndexedStack(
                        alignment: AlignmentDirectional.center,
                        index: appState().tabBarIndex.value, // currentIndex,
                        children: [
                          Text(GlobalConfig.tabTitles[0]),
                          Text(GlobalConfig.tabTitles[1]),
                          Text(GlobalConfig.tabTitles[2])
                        ],
                      ),
                      toolbarHeight: 40,
                    ),
              drawer:
                  appState().tabBarIndex.value == 0 ? const MainDrawer() : null,
              drawerEdgeDragWidth: 100,
              drawerDragStartBehavior: DragStartBehavior.down,
              body: IndexedStack(
                alignment: AlignmentDirectional.center,
                //使用IndexedStack，TabBar切换时，body不会重新渲染
                index: appState().tabBarIndex.value,
                children: const [MusicPage(), MoviePage(), PersonalPage()],
              ),
              bottomNavigationBar: const BottomTabBarWidget(),
            )));
  }
}
