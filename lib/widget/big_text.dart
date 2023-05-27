// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  late final String text;
  late final Color color;
  late final double fontSize;
  late TextOverflow overflow;
  late FontWeight fontWeight;


  BigText(  {Key? key, this.fontWeight=FontWeight.w600, this.color = const Color(0xFF332e2b),this.fontSize =23,this.overflow = TextOverflow.ellipsis, required this.text}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontFamily: 'Roboto',
      ),
      overflow: overflow,
    );
  }
}
