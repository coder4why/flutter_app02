// ignore: file_names
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'model/PersonalModel.dart';

class PersonalDetail extends StatefulWidget {
  final PersonalModel jsonModel;
  const PersonalDetail(this.jsonModel, {Key? key}) : super(key: key);
  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
  late VideoPlayerController _playerController;
  bool initSuccess = false;
  @override
  void initState() {
    super.initState();
    _playerController = VideoPlayerController.network(widget.jsonModel.playUrl)
      ..setVolume(1)
      ..seekTo(Duration.zero)
      ..initialize().then((_) {
        setState(() {
          initSuccess = true;
        });
        _playerController.play();
      }).onError((error, stackTrace) {});
  }

  @override
  void dispose() {
    super.dispose();
    _playerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jsonModel.userName),
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // width: MediaQuery.of(context).size.width - 30,
              // height: 230,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              child: initSuccess
                  ? AspectRatio(
                      aspectRatio: _playerController.value.aspectRatio,
                      child: VideoPlayer(_playerController),
                    )
                  : Image.network(
                      widget.jsonModel.coverUrl,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.jsonModel.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          setState(() {
            //_controller.value.isPlaying：判断视频是否正在播放
            //_controller.pause()：如果是则暂停视频。
            // _controller.play():如果不是则播放视频
            _playerController.value.isPlaying
                ? _playerController.pause()
                : _playerController.play();
          });
        },

        //子组件为按钮图标
        //_controller.value.isPlaying：判断视频是否正在播放
        //Icons.pause：如果是则显示这个图标
        //Icons.play_arrow：如果不是，则显示这个图标
        child: Icon(
          initSuccess ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }
}
