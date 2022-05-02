// ignore: file_names
import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final String content;
  const CenterText(this.content, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content,
        style: const TextStyle(fontSize: 25, color: Colors.orange),
      ),
    );
  }
}
