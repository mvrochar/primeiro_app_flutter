import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  var controller;
  String labelText;

  Input({this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}
