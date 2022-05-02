// ignore: file_names
import 'package:flutter/material.dart';
import '../../request/request.dart';
import 'model/ListenModel.dart';

class ListenPage extends StatefulWidget {
  const ListenPage({Key? key}) : super(key: key);

  @override
  State<ListenPage> createState() => _ListenPageState();
}

//豆瓣电影api
//https://api.wmdb.tv/api/v1/top?type=Imdb&skip=0&limit=20&lang=Cn
class _ListenPageState extends State<ListenPage> {
  List<ListenItem> listItems = [];
  @override
  void initState() {
    super.initState();
    Request.get('http://music.cyrilstudio.top/personalized', (response) {
      if (response['code'] == 200) {
        var result = response['result'];
        List<ListenItem> lists = [];
        for (var element in result) {
          ListenModel jsonModel = ListenModel.fromJson(element);
          lists.add(ListenItem(jsonModel));
        }
        setState(() {
          listItems = lists;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView(
        children: [...listItems, const SizedBox(height: 10)],
      ),
    );
  }
}

class ListenItem extends StatelessWidget {
  final ListenModel jsonModel;
  const ListenItem(this.jsonModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 214, 211, 211))),
        child: Column(
          children: [
            Text(
              jsonModel.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Image.network(
              jsonModel.picUrl,
              fit: BoxFit.fill,
            ),
          ],
        ));
  }
}
