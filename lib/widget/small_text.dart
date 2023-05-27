// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  late final String text;
  late final Color color;
  late final double fontSize;
  late double hight;


  SmallText(  {Key? key, this.color = const Color(0xFFccc7c5),this.fontSize =12,this.hight =1.2, required this.text}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontFamily: 'Roboto',
        height: hight,

      ),
    );
  }
}
