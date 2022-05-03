// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app02/pages/personal/PersonalDetail.dart';
import 'package:flutter_app02/pages/personal/model/PersonalModel.dart';
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
          accountName: Text('CODER4WHY'),
          accountEmail: Text('1888888888@163.com'),
          currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F1%2Fba%2Ff855c8c1d9.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1654137339&t=01dbdf39305ed24f8bfa5a19e803c22f',
              )),
        ),
        renderTile(0, context),
        renderTile(1, context),
        renderTile(2, context),
      ]),
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height,
    );
  }
}

ListTile renderTile(index, context) {
  List<String> titles = ['HOME', 'MOVIE', 'PERSONAL'];
  List<IconData> icons = [
    Icons.air,
    Icons.movie_filter_outlined,
    Icons.gps_not_fixed_outlined
  ];
  return ListTile(
    title: Text(
      titles[index],
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      textAlign: TextAlign.left,
    ),
    trailing: Icon(icons[index], color: Colors.black87, size: 22.0),
    onTap: () {
      Get.back();
      // Navigator.pop(context);
      if (index == 0) return;
      Future.delayed(const Duration(milliseconds: 200), () {
        tabState().switchIndex(index);
      });
    },
  );
}
