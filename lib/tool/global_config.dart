import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Themes {
  static final pink = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      useMaterial3: false,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.pink),
      colorScheme: const ColorScheme.light(primary: Colors.pink),
      primaryColor: Colors.white);

  static final blue = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      useMaterial3: false,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
      colorScheme: const ColorScheme.light(primary: Colors.blue),
      primaryColor: Colors.white);
}

class MainState {
  RxInt tabBarIndex = 0.obs;
  RxBool isPink = true.obs;
  switchIndex(index) {
    tabBarIndex.value = index;
  }

  changeTheme() {
    Get.changeTheme(isPink.value ? Themes.blue : Themes.pink);
    isPink.value = !isPink.value;
  }
}

final MainState mainState = MainState();
MainState appState() {
  return mainState;
}

class GlobalConfig {
  static const List<IconData> tabIcons = [
    Icons.air,
    Icons.movie_filter_outlined,
    Icons.beach_access_outlined
  ];
  static const List<String> tabTitles = ['HOME', 'MOVIE', 'VIDEO'];
  static const List<String> tabZwTitles = ['首页', '电影', '视频'];
}
