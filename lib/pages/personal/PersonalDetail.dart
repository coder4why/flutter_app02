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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
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
            //_controller.value.isPlaying?????????????????????????????????
            //_controller.pause()??????????????????????????????
            // _controller.play():???????????????????????????
            _playerController.value.isPlaying
                ? _playerController.pause()
                : _playerController.play();
          });
        },

        //????????????????????????
        //_controller.value.isPlaying?????????????????????????????????
        //Icons.pause?????????????????????????????????
        //Icons.play_arrow???????????????????????????????????????
        child: Icon(
          initSuccess && _playerController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }
}
