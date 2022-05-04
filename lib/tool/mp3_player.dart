import 'package:audioplayers/audioplayers.dart';

class Mp3Player {
  static AudioPlayer getInstance() {
    AudioPlayer audioPlayer = AudioPlayer();
    return audioPlayer;
  }

  static void playMp3(String url) async {
    getInstance().pause();
    releasePlayer();
    int result = await getInstance().play(url);
    if (result == 1) {
      //播放成功
    } else {
      //播放失败
    }
  }

  static void pauseMp3() async {
    int result = await getInstance().pause();
    if (result == 1) {
      //暂停成功
    } else {
      //暂停失败
    }
  }

  static void releasePlayer() async {
    int result = await getInstance().release();
    if (result == 1) {
      //释放成功
    }
  }
}
