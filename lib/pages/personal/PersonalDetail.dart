// ignore: file_names
import 'package:flutter/material.dart';
import 'model/PersonalModel.dart';

class PersonalDetail extends StatefulWidget {
  final PersonalModel jsonModel;
  const PersonalDetail(this.jsonModel, {Key? key}) : super(key: key);
  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
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
              width: MediaQuery.of(context).size.width - 30,
              height: 230,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              child: Image.network(
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
    );
  }
}
