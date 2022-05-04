// ignore: file_names
class MusicModel {
  /* 获取音乐排行榜：
  classify: 
    1 热播榜
    2 新歌榜
    3 特色榜
    4 全球榜
    5 曲风榜
  */
  List<MusicRankModel> classify_1 = [];
  List<MusicRankModel> classify_2 = [];
  List<MusicRankModel> classify_3 = [];
  List<MusicRankModel> classify_4 = [];
  List<MusicRankModel> classify_5 = [];
  MusicModel();
}

class MusicRankModel {
  String rankname = '';
  String rankid = '';
  String playTimes = '';
  // String customType = '';
  String ranktype = '';

  // String showPlayButton = '0';
  String intro = '';
  String classify = '';
  String imgurl = ''; //封面图
  // String categoryUrl = '';

  MusicRankModel();

  List<RankSongInfo> songs = [];
  MusicRankModel.fromMap(Map<String, dynamic> element) {
    rankname = element['rankname'] ?? '';
    rankid = (element['rankid'] ?? '').toString();
    playTimes = (element['play_times'] ?? '').toString();
    // customType = (element['custom_type'] ?? '').toString();
    ranktype = (element['ranktype'] ?? '').toString();
    // showPlayButton = (element['show_play_button'] ?? '').toString();
    intro = (element['intro'] ?? '').toString();
    classify = (element['classify'] ?? '').toString();
    imgurl = (element['imgurl'] ?? '').toString().replaceAll('{size}', '240');
    // categoryUrl =
    //     (element['banner_9'] ?? '').toString().replaceAll('{size}', '240');
  }

  @override
  String toString() {
    return '$rankname,$rankid,$playTimes,$ranktype,$classify,$imgurl';
    // return super.toString();
  }
}

class RankSongInfo {
  int rankCount = 0;
  String sqhash = '';
  String albumId = '';
  String hash = '';
  String hash320 = '';
  String audioId = '';
  String albumSizableCover = '';
  String remark = '';
  String filename = '';
  String addtime = '';
  String songUrl = '';
  String singer = '';
  RankSongInfo.fromMap(Map<String, dynamic> element) {
    rankCount = (element['rank_count'] ?? '');
    sqhash = (element['sqhash'] ?? '');
    albumId = (element['album_id'] ?? '');
    hash = element['hash'] ?? '';
    // hashHigh = element['hash_high'] ?? '';
    hash320 = element['320hash'] ?? '';
    audioId = (element['audio_id'] ?? '').toString();
    albumSizableCover =
        (element['album_sizable_cover'] ?? '').replaceAll('{size}', '240');
    remark = element['remark'] ?? '';
    filename = element['filename'] ?? '';
    addtime = element['addtime'] ?? '';
    songUrl = element['song_url'] ?? '';
    singer = filename;
    if (filename.contains('-')) {
      int index = filename.indexOf('-');
      singer = filename.substring(0, index);
    }
  }
}

class MusicSearchModel {
  String songnameOriginal = '';
  String singername = '';
  String filename = '';
  String hash = '';
  String mvhash = '';
  String hash320 = '';
  String sqhash = '';
  String duration = '';
  String albumName = '';

  MusicSearchModel.fromMap(Map<String, dynamic> element) {
    songnameOriginal = element['songname_original'] ?? '';
    singername = element['singername'] ?? '';
    filename = element['filename'] ?? '';
    hash = element['hash'] ?? '';
    mvhash = element['mvhash'] ?? '';
    hash320 = element['320hash'] ?? '';
    sqhash = element['sqhash'] ?? '';
    duration = (element['duration'] ?? '').toString();
    albumName = element['album_name'] ?? '';
  }
}

class MusicInfoModel {
  List<SingerInfoModel> authors = [];
  String authorName = '';
  String url = ''; //音频播放链接，存在为空情况
  String choricSinger = '';
  String fileName = '';
  String singerName = '';
  String albumImg = '';
  String songName = '';
  String imgUrl = '';
  String singerId = '';
  String reqHash = '';
  MusicInfoModel.fromMap(Map<String, dynamic> element) {
    authorName = element['author_name'] ?? '';
    url = element['url'] ?? '';
    choricSinger = element['choricSinger'] ?? '';
    fileName = element['fileName'] ?? '';
    singerName = element['singerName'] ?? '';
    albumImg = element['album_img'] ?? '';
    songName = element['songName'] ?? '';
    imgUrl = element['imgUrl'] ?? '';
    singerId = (element['singerId'] ?? '').toString();
    reqHash = element['req_hash'] ?? '';
    List<dynamic> list = element['authors'] ?? [];
    for (var item in list) {
      authors.add(SingerInfoModel.fromMap(item));
    }
  }
}

class SingerInfoModel {
  String birthday = '';
  String avatar = '';
  String language = '';
  String country = '';
  String authorName = '';
  SingerInfoModel.fromMap(Map<String, dynamic> element) {
    birthday = element['birthday'] ?? '';
    avatar = ((element['avatar'] as String?) ?? '').replaceAll('{size}', '240');
    language = element['language'] ?? '';
    country = element['country'] ?? '';
    authorName = element['author_name'] ?? '';
  }
}

//MV搜索的model
class MuisicMvSearchModel {
  String thumbGif = '';
  String mvName = '';
  String mvHash = '';
  String mvHashMark = '';
  String singerName = '';

  // String thumbMp4 = '';
  String fileName = '';
  String fileHash = '';
  String duration = '';
  MuisicMvSearchModel.fromMap(Map<String, dynamic> element) {
    thumbGif = element['ThumbGif'] ?? '';
    mvName = element['MvName'] ?? '';
    mvHash = element['MvHash'] ?? '';
    mvHashMark = element['MvHashMark'] ?? '';
    singerName = element['SingerName'] ?? '';
    fileName = element['FileName'] ?? '';
    fileHash = element['FileHash'] ?? '';
    duration = (element['Duration'] ?? '').toString();
  }
}

//MV播放的model
class MusicMvInfoModel {
  late MvPlayModel mvdata;
  String hash = '';
  String singer = '';
  String publishDate = '';
  String songname = '';
  String mvicon = '';
  String timelength = '';
  String commentCount = '';
  String playCount = '';
  String collectCount = '';
  String likeCount = '';
  MusicMvInfoModel.fromMap(Map<String, dynamic> element) {
    hash = element['hash'] ?? '';
    singer = element['singer'] ?? '';
    publishDate = element['publish_date'] ?? '';
    songname = element['songname'] ?? '';
    mvicon = element['mvicon'] ?? '';
    timelength = (element['timelength'] ?? 0).toString();
    commentCount = (element['comment_count'] ?? 0).toString();
    playCount = (element['play_count'] ?? 0).toString();
    collectCount = (element['collect_count'] ?? 0).toString();
    likeCount = (element['like_count'] ?? 0).toString();
    Map<String, dynamic> mvdataInfo = (element['mvdata'] as Map)['rq'];
    mvdata = MvPlayModel.fromMap(mvdataInfo);
  }
}

class MvPlayModel {
  String hash = '';
  // String backupdownurl = '';
  String timelength = '';
  String filesize = '';
  String downurl = '';
  MvPlayModel.fromMap(Map<String, dynamic> element) {
    hash = element['hash'] ?? '';
    timelength = (element['timelength'] ?? '').toString();
    filesize = (element['filesize'] ?? '').toString();
    downurl = element['downurl'] ?? '';
    // backupdownurl = (element['backupdownurl'] as List).isNotEmpty
    //     ? (element['backupdownurl'] as List)[0]
    //     : '';
  }
}
