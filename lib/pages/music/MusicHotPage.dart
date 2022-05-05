// ignore: file_names
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../tool/global_config.dart';
import 'model/music_model.dart';
import 'request/request_music.dart';

class MusicHotPage extends StatefulWidget {
  final MusicRankModel rankModel;
  const MusicHotPage(
    this.rankModel, {
    Key? key,
  }) : super(key: key);

  @override
  State<MusicHotPage> createState() => _MusicHotPageState();
}

class _MusicHotPageState extends State<MusicHotPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  MusicRankModel dataModel = MusicRankModel();
  RankSongInfo playModel = RankSongInfo();
  Color mainColor = GlobalConfig.getRandamColor();
  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    playModel.hash = '';
    playModel.isPlaying = false;
  }

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        playModel.isPlaying = false;
      });
    });
    if (widget.rankModel.songs.isEmpty) {
      RequestMusic.requestSongRankList(widget.rankModel, (model) {
        setState(() {
          dataModel = model;
        });
      });
    } else {
      setState(() {
        dataModel = widget.rankModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return dataModel.songs.isEmpty
        ? const SizedBox()
        : Scaffold(
            body: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 44, 0, 40),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            //渐变位置
                            begin: Alignment.topLeft, //右上
                            end: Alignment.topRight, //左下
                            colors: [
                          Colors.white,
                          mainColor,
                          Colors.white,
                        ])),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => {Get.back()},
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 20,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.more_vert_sharp,
                                color: Colors.black,
                                size: 20,
                              )),
                        ],
                      ),
                      Text(
                        dataModel.rankname,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 24,
                        width: MediaQuery.of(context).size.width / 3.0 + 20,
                        alignment: Alignment.center,
                        clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                            color: Colors.white.withAlpha(140),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        child: Text(
                          dataModel.intro,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                      child: ListView(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    children: [rendTitle(), ...renderList()],
                  ))
                ]),
          ));
  }

  Widget rendTitle() {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(children: [
        Icon(
          Icons.play_circle_rounded,
          color: mainColor,
          size: 17,
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          '播放全部',
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        const Expanded(child: SizedBox()),
        Icon(
          Icons.cached_sharp,
          color: mainColor,
          size: 20,
        ),
        const SizedBox(
          width: 20,
        ),
        const Icon(
          Icons.menu,
          color: Colors.black,
          size: 20,
        )
      ]),
    );
  }

  List<Widget> renderList() {
    List<Widget> list = [];
    for (int i = 0; i < dataModel.songs.length; i++) {
      RankSongInfo songInfo = dataModel.songs[i];
      list.add(GestureDetector(
        onTap: () {
          if (audioPlayer.state == PlayerState.PLAYING &&
              songInfo.hash == playModel.hash) {
            audioPlayer.pause();
            setState(() {
              playModel.isPlaying = false;
            });
            return;
          }
          RequestMusic.requestMusicUrl(songInfo.hash, (MusicInfoModel model) {
            if (model.url.isNotEmpty) {
              if (audioPlayer.state == PlayerState.PLAYING) {
                audioPlayer.pause();
              }
              audioPlayer.play(model.url);
              //刷新播放按钮：
              List<RankSongInfo> allSongs = dataModel.songs;
              for (var item in allSongs) {
                item.isPlaying = item.hash == songInfo.hash;
              }
              songInfo.isPlaying = true;
              setState(() {
                dataModel.songs = allSongs;
                playModel = songInfo;
              });
            } else {
              Get.defaultDialog(
                  title: '播放失败',
                  middleText: '需要开通VIP权限，才可以哦！',
                  titlePadding: const EdgeInsets.only(top: 20),
                  titleStyle: const TextStyle(fontSize: 18));
            }
          });
        },
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.add_circle,
                  color: Color.fromARGB(66, 93, 93, 93),
                  size: 20,
                ),
                SizedBox(
                  width: i < 3 ? 8 : 10,
                ),
                SizedBox(
                  // width: 20,
                  child: Text(
                    '${i + 1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: i < 3 ? mainColor : Colors.black54,
                        fontSize: i < 3 ? 18 : 14,
                        fontWeight:
                            i < 3 ? FontWeight.bold : FontWeight.normal),
                  ),
                ),
                Container(
                  width: 35,
                  height: 35,
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Image.network(songInfo.albumSizableCover),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2.0),
                      child: Text(
                        songInfo.remark,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textHeightBehavior: const TextHeightBehavior(
                            applyHeightToFirstAscent: false),
                        style: TextStyle(
                            fontSize: playModel.isPlaying &&
                                    songInfo.hash == playModel.hash
                                ? 16
                                : 14,
                            color: playModel.isPlaying &&
                                    songInfo.hash == playModel.hash
                                ? mainColor
                                : Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2.0),
                      child: Text(
                        songInfo.filename,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
                      ),
                    )
                  ],
                ),
                const Expanded(child: SizedBox()),
                Icon(
                    playModel.isPlaying && songInfo.hash == playModel.hash
                        ? Icons.pause_circle_filled_sharp
                        : Icons.play_circle_sharp,
                    color: const Color.fromARGB(66, 93, 93, 93),
                    size: 20),
                const SizedBox(
                  width: 15,
                ),
                const Icon(Icons.more_vert_sharp,
                    color: Colors.black26, size: 18),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ));
    }
    return list;
  }
}
