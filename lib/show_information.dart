import 'package:flutter/material.dart';

class ShowInformation extends StatelessWidget {
  String text = '';
  var data;

  ShowInformation({this.text, this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      text + data,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.left,
    );
  }
}
