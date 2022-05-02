import 'package:flutter/material.dart';
import 'components/BottomTabBarWidget.dart';
import 'pages/listen/ListenPage.dart';
import 'pages/main/MainPage.dart';
import 'pages/personal/PersonalPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const HomeWidget(),
        theme: ThemeData(
            //splashColor highlightColor：全局去除按钮点击的水波纹效果
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            useMaterial3: false,
            colorScheme: const ColorScheme.light(primary: Colors.teal),
            primaryColor: Colors.white));
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
  int currentIndex = 0;
  tapSwitch(value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IndexedStack(
          alignment: AlignmentDirectional.center,
          index: currentIndex,
          children: const [Text('CODERWHY'), Text('CENTER'), Text('PERSONAL')],
        ),
        toolbarHeight: 44,
      ),
      body: IndexedStack(
        alignment: AlignmentDirectional.center,
        //使用IndexedStack，TabBar切换时，body不会重新渲染
        index: currentIndex,
        children: [MainPage(), const ListenPage(), const PersonalPage()],
      ),
      bottomNavigationBar: BottomTabBarWidget(tapSwitch),
    );
  }
}
