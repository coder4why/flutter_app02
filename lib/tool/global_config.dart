import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Themes {
  static final pink = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      useMaterial3: false,
      appBarTheme: AppBarTheme(backgroundColor: GlobalConfig.musicColors[0]),
      colorScheme: ColorScheme.light(primary: GlobalConfig.musicColors[0]),
      primaryColor: Colors.white);

  static final blue = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      useMaterial3: false,
      appBarTheme: AppBarTheme(backgroundColor: GlobalConfig.musicColors[8]),
      colorScheme: ColorScheme.light(primary: GlobalConfig.musicColors[8]),
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

  static const List<Color> musicColors = [
    Color.fromARGB(255, 245, 112, 156),
    Color.fromARGB(255, 196, 254, 196),
    Color.fromARGB(255, 237, 252, 161),
    Color.fromARGB(255, 241, 203, 246),
    Color.fromARGB(255, 247, 195, 237),
    Color.fromARGB(255, 248, 244, 211),
    Color.fromARGB(255, 173, 226, 248),
    Color.fromARGB(255, 236, 237, 200),
    Color.fromARGB(255, 118, 151, 247),
  ];

  static Color getRandamColor() {
    int index = (Random()).nextInt(musicColors.length - 1);
    return musicColors[index];
  }
}
