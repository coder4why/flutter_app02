// ignore: file_names
class ListenModel {
  String name = '';
  String picUrl = '';
  ListenModel.fromJson(Map<String, dynamic> element) {
    name = element['name'];
    picUrl = element['picUrl'];
  }
}
