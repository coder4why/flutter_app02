// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'MusicHotPage.dart';
import 'model/music_model.dart';
import 'request/request_music.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);
  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  MusicModel dataModel = MusicModel();
  @override
  void initState() {
    super.initState();
    RequestMusic.requestMusicRankList((model) {
      setState(() {
        dataModel = model;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return dataModel.classify_1.isEmpty
        ? const SizedBox()
        : ListView(
            padding: const EdgeInsets.all(15),
            children: getChildrens(dataModel, context));
  }
}

List<Widget> getChildrens(MusicModel model, BuildContext context) {
  List<Map> showModels = [
    {'name': '热播榜', 'index': 1, 'models': model.classify_1},
    {'name': '新歌榜', 'index': 2, 'models': model.classify_2},
    {'name': '曲风榜', 'index': 3, 'models': model.classify_5},
    {'name': '特色榜', 'index': 4, 'models': model.classify_3},
    {'name': '全球榜', 'index': 5, 'models': model.classify_4},
  ];

  List<Widget> chilrens = [];
  for (var element in showModels) {
    chilrens.add(renderItem(element, context));
  }
  return chilrens;
}

Widget renderItem(Map element, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        element['name'],
        style: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 10,
      ),
      GridView.builder(
          itemCount: element['models'].length,
          shrinkWrap: true,
          //解决无线高度问题
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: element['index'] == 1 ? 1 : 3,
              //纵轴间距
              mainAxisSpacing: 10.0,
              //横轴间距
              crossAxisSpacing: 10.0,
              //子组件宽高长度比例
              childAspectRatio: element['index'] == 1
                  ? (MediaQuery.of(context).size.width - 20) /
                      ((MediaQuery.of(context).size.width - 50) / 3.0)
                  : 1.0),
          itemBuilder: (BuildContext context, int index) {
            if (element['index'] == 1) {
              return getHotItem(element['models'][index], context);
            } else {
              return getCard(element['models'][index], context);
            }
          }),
      const SizedBox(
        height: 10,
      ),
      //     )
    ],
  );
}

List<Widget> rendeSubItem(
    List<MusicRankModel> models, int index, BuildContext context) {
  return models.map((e) {
    if (index == 1) {
      return getHotItem(e, context);
    } else {
      return getCard(e, context);
    }
  }).toList();
}

Widget getCard(MusicRankModel e, BuildContext context, {bool isHot = false}) {
  return GestureDetector(
    onTap: () {
      Get.to(() => MusicHotPage(e));
    },
    child: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image:
                NetworkImage(isHot ? e.songs[0].albumSizableCover : e.imgurl),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 8,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                e.playTimes,
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              const SizedBox(
                width: 5,
              )
            ],
          ),
          const SizedBox(
            height: 3,
          )
        ],
      ),
      width: (MediaQuery.of(context).size.width - 50) / 3.0,
      height: (MediaQuery.of(context).size.width - 50) / 3.0,
    ),
  );
}

Widget getHotItem(MusicRankModel e, BuildContext context) {
  return GestureDetector(
      onTap: () {
        Get.to(() => MusicHotPage(e));
      },
      child: Container(
          clipBehavior: Clip.hardEdge,
          width: MediaQuery.of(context).size.width - 20,
          height: (MediaQuery.of(context).size.width - 50) / 3.0,
          decoration: const BoxDecoration(
              color: Color.fromARGB(95, 212, 209, 209),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(children: [
            getCard(e, context, isHot: true),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 3,
                ),
                Text(
                  e.rankname,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                ...renderHotSong(e.songs),
                const SizedBox(
                  height: 5,
                )
              ],
            )
          ])));
}

List<Widget> renderHotSong(List<RankSongInfo> song) {
  List<Widget> list = [];
  for (int i = 0; i < (song.length > 3 ? 3 : song.length); i++) {
    list.add(Row(
      children: [
        ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1250),
            child: Text(
              '${i + 1}.${song[i].remark}',
              maxLines: 1,
              style: const TextStyle(fontSize: 12, color: Colors.black),
            )),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 70),
          child: Text(' - ' + song[i].singer,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis),
        ),
      ],
    ));
  }
  return list;
}
