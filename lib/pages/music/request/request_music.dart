/*
获取音乐排行榜，查询rankid： 
http://m.kugou.com/rank/list&json=true

根据rankid查询歌曲排行单，拿到歌曲列表，获取到歌曲的sqhash：
http://m.kugou.com/rank/info/?rankid=44412&page=1&json=true

音乐搜索，获取mp3的hash字段：
http://mobilecdn.kugou.com/api/v3/search/song?format=json&keyword=周杰伦&page=1&pagesize=20&showtype=1

传入hash，获取音频链接url：
http://m.kugou.com/app/i/getSongInfo.php?cmd=playInfo&hash=681BC0CD079325E67975F255B13F7E19

关键字搜索MV：
http://mvsearch.kugou.com/mv_search?keyword=higher&page=1&pagesize=30&userid=-1&clientver=&platform=WebFilter&tag=em&filter=2&iscorrection=1&privilege_filter=0&_=1515052279917

获取MV的播放链接：
http://m.kugou.com/app/i/mv.php?cmd=100&hash=F5B70600F3428A47BC4A0F35129EDC33&ismp3=1&ext=mp4
*/

import 'dart:convert';
import '../../../request/request.dart';
import '../model/music_model.dart';

class RequestMusic {
  /* 获取音乐排行榜：
  classify: 
    1 热播榜
    2 新歌榜
    3 特色榜
    4 全球榜
    5 曲风榜
  */
  static void requestMusicRankList(callback) {
    Request.get('http://m.kugou.com/rank/list&json=true', (response) {
      Map<String, dynamic> result = json.decode((response as String));
      List<dynamic> rankList =
          ((result['rank'] as Map)['list'] as List<dynamic>);
      List<MusicRankModel> classifyNew1 = [];
      List<MusicRankModel> classify_2 = [];
      List<MusicRankModel> classify_3 = [];
      List<MusicRankModel> classify_4 = [];
      List<MusicRankModel> classify_5 = [];
      for (var element in rankList) {
        MusicRankModel rankModel = MusicRankModel.fromMap(element);
        if (rankModel.classify == '1') {
          //热播榜
          classifyNew1.add(rankModel);
        } else if (rankModel.classify == '2') {
          //新歌榜
          classify_2.add(rankModel);
        } else if (rankModel.classify == '3') {
          //特色榜
          classify_3.add(rankModel);
        } else if (rankModel.classify == '4') {
          //全球榜
          classify_4.add(rankModel);
        } else if (rankModel.classify == '5') {
          //曲风榜
          classify_5.add(rankModel);
        }
      }
      int count = 0;
      List<MusicRankModel> classify_1 = [];
      for (int i = 0; i < classifyNew1.length; i++) {
        MusicRankModel rankModel = classifyNew1[i];
        requestSongRankList(rankModel, (model) {
          classify_1.add(model);
          count++;
          if (count >= classifyNew1.length) {
            MusicModel newModel = MusicModel();
            newModel.classify_1 = classify_1;
            newModel.classify_2 = classify_2;
            newModel.classify_3 = classify_3;
            newModel.classify_4 = classify_4;
            newModel.classify_5 = classify_5;
            callback(newModel);
          }
        });
      }
    });
  }

  //获取新歌榜单：
  static void requestNewestSongs(callback) {
    Request.get('http://m.kugou.com/?json=true', (response) {
      Map<String, dynamic> result = json.decode((response as String));
      List songs = result['data'];
      List<RankSongInfo> newSongs = [];
      for (var element in songs) {
        newSongs.add(RankSongInfo.fromMap(element));
      }
      callback(newSongs);
    });
  }

  //根据rankid查询歌曲排行单，拿到歌曲列表，获取到歌曲的hash
  static void requestSongRankList(MusicRankModel model, callback) {
    MusicRankModel musicRankModel = model;
    Request.get(
        'http://m.kugou.com/rank/info/?rankid=${model.rankid}&page=1&json=true',
        (response) {
      Map<String, dynamic> result = json.decode((response as String));
      List songLists = (result['songs'] as Map)['list'];
      List<RankSongInfo> songs = [];
      for (int i = 0; i < songLists.length; i++) {
        Map<String, dynamic> element = songLists[i];
        RankSongInfo songInfo = RankSongInfo.fromMap(element);
        songs.add(songInfo);
      }
      musicRankModel.songs = songs;
      callback(musicRankModel);
    });
  }

  //音乐搜索，获取mp3的hash字段：
  static void requestSongSearchList(String keyword, callback) {
    List<MusicSearchModel> list = [];
    Request.get(
        'http://mobilecdn.kugou.com/api/v3/search/song?format=json&keyword=$keyword&page=1&pagesize=20&showtype=1',
        (response) {
      Map<String, dynamic> result = json.decode((response as String));
      List musics = (result['data'] as Map)['info'] as List;
      for (var element in musics) {
        list.add(MusicSearchModel.fromMap(element));
      }
      callback(list);
    });
  }

  //传入hash，获取音频链接url：
  static void requestMusicUrl(String hash, callback) {
    Request.get(
        'http://m.kugou.com/app/i/getSongInfo.php?cmd=playInfo&hash=$hash',
        (response) {
      Map<String, dynamic> result = json.decode((response as String));
      MusicInfoModel model = MusicInfoModel.fromMap(result);
      callback(model);
    });
  }

  //关键字搜索MV：
  static void requestMvSearchList(String keyword, callback) {
    List<MuisicMvSearchModel> list = [];
    Request.get(
        'http://mvsearch.kugou.com/mv_search?keyword=$keyword&page=1&pagesize=20&userid=-1&clientver=&platform=WebFilter&tag=em&filter=2&iscorrection=1&privilege_filter=0&_=1515052279917',
        (response) {
      Map<String, dynamic> result = json.decode((response as String));
      List mvs = (result['data'] as Map)['lists'] as List;
      for (var element in mvs) {
        list.add(MuisicMvSearchModel.fromMap(element));
      }
      callback(list);
    });
  }

  //获取MV的播放链接：
  static void requestMvUrl(String hash, callback) {
    Request.get(
        'http://m.kugou.com/app/i/mv.php?cmd=100&hash=$hash&ismp3=1&ext=mp4',
        (response) {
      Map<String, dynamic> result = json.decode((response as String));
      MusicMvInfoModel model = MusicMvInfoModel.fromMap(result);
      callback(model);
    });
  }
}
