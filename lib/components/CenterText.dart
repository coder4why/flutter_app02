// ignore: file_names
import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final String content;
  final TextStyle textStyle;
  const CenterText(this.content,
      {Key? key,
      this.textStyle = const TextStyle(fontSize: 25, color: Colors.black)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content,
        style: textStyle,
      ),
    );
  }
}
