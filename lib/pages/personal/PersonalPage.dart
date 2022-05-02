// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_app02/pages/personal/model/PersonalModel.dart';
import 'package:flutter_app02/request/request.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return PersonalPageWidget();
  }
}

class PersonalPageWidget extends State<PersonalPage> {
  List<PersonalModel> dataModels = [];
  List<PersonItemWidget> showItems = [];
  final ScrollController _scrollController = ScrollController();
  int page = 0;
  @override
  void initState() {
    super.initState();
    loadMore(true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore(false);
      }
    });
  }

  loadMore(bool start) {
    if (!start) {
      page++;
    }
    Request.get('https://api.apiopen.top/api/getHaoKanVideo?page=$page&size=3',
        (response) {
      if (response['code'] == 200) {
        var result = response['result'];
        List<dynamic> list = result['list'];
        List<PersonalModel> listModels = dataModels;
        List<PersonItemWidget> allItems = showItems;
        for (var element in list) {
          PersonalModel model = PersonalModel.formJson(element);
          listModels.add(model);
          allItems.add(PersonItemWidget(model));
        }
        setState(() {
          dataModels = listModels;
          showItems = allItems;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: () {
              loadMore(false);
              return Future.value();
            },
            child: ListView(
              controller: _scrollController,
              children: [
                ...showItems,
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/loadMore.png',
                        width: 18,
                        height: 18,
                        color: Colors.orange,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        '拼命加载中...',
                        style: TextStyle(color: Colors.orange, fontSize: 16),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}

class PersonItemWidget extends StatelessWidget {
  final PersonalModel jsonModel;

  const PersonItemWidget(this.jsonModel, {Key? key}) : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            jsonModel.userName,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            jsonModel.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 6,
          ),
          Image.network(
            jsonModel.coverUrl,
            height: 200,
            fit: BoxFit.fitHeight,
          ),
        ],
      ),
    );
  }
}