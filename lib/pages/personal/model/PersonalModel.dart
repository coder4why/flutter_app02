// ignore: file_names
class PersonalModel {
  String title = '';
  String userName = '';
  String userPic = '';
  String coverUrl = '';
  String playUrl = '';
  String duration = '';

  PersonalModel.formJson(Map<String, dynamic> element) {
    title = element['title'];
    userName = element['userName'];
    userPic = element['userPic'];
    coverUrl = element['coverUrl'];
    playUrl = element['playUrl'];
    duration = element['duration'];
  }
}
