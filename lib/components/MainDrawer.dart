// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../tool/global_config.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(children: [
        const UserAccountsDrawerHeader(
          accountName: Text(
            'CODER4WHY',
            style: TextStyle(color: Colors.black54),
          ),
          accountEmail: Text('1888888888@163.com',
              style: TextStyle(color: Colors.black38)),
          currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F1%2Fba%2Ff855c8c1d9.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1654137339&t=01dbdf39305ed24f8bfa5a19e803c22f',
              )),
        ),
        renderTile(0, context),
        renderTile(1, context),
        renderTile(2, context),
        const Expanded(
          child: SizedBox(),
        ),
        ListTile(
          title: const Text(
            'THEME',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          trailing: Icon(
              appState().isPink.value
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_outlined,
              color: Colors.black87,
              size: 22.0),
          onTap: () {
            appState().changeTheme();
            Get.back();
          },
        ),
        const SizedBox(
          height: 20,
        )
      ]),
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height,
    );
  }
}

ListTile renderTile(index, context) {
  return ListTile(
    title: Text(
      GlobalConfig.tabTitles[index],
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      textAlign: TextAlign.left,
    ),
    trailing:
        Icon(GlobalConfig.tabIcons[index], color: Colors.black87, size: 22.0),
    onTap: () {
      Get.back();
      // Navigator.pop(context);
      if (index == 0) return;
      Future.delayed(const Duration(milliseconds: 200), () {
        appState().switchIndex(index);
      });
    },
  );
}
