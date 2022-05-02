// ignore: file_names
import 'package:flutter/material.dart';
import '../../request/request.dart';
import 'model/MovieModel.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

//豆瓣电影api
//http://music.cyrilstudio.top/personalized
class _MoviePageState extends State<MoviePage> {
  List<MovieItem> listItems = [];
  @override
  void initState() {
    super.initState();
    Request.get(
        'https://api.wmdb.tv/api/v1/top?type=Imdb&skip=0&limit=20&lang=Cn',
        (response) {
      var result = response;
      List<MovieItem> lists = [];
      int i = 0;
      for (var element in result) {
        MovieModel jsonModel = MovieModel.fromJson(element);
        i++;
        jsonModel.rankIndex = '$i';
        lists.add(MovieItem(jsonModel));
      }
      setState(() {
        listItems = lists;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [...listItems, const SizedBox(height: 10)],
      ),
    );
  }
}

class MovieItem extends StatelessWidget {
  final MovieModel jsonModel;
  const MovieItem(this.jsonModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: const Color.fromARGB(255, 223, 220, 220)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 239, 216, 180),
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: Text(
                    'NO.${jsonModel.rankIndex}',
                    style: const TextStyle(color: Colors.brown, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${jsonModel.movieModel.name}(${jsonModel.year})',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            Text(
              jsonModel.alias,
              maxLines: 4,
              style: const TextStyle(color: Colors.black54, fontSize: 15),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 230,
              width: MediaQuery.of(context).size.width - 20,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              child: Image.network(
                jsonModel.movieModel.poster,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ));
  }
}
