// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


class AppIcon extends StatelessWidget {

  late final IconData icon;
  late Color backgroundColor;
  late Color iconColor;
  late double size;

  AppIcon(
    this.icon,{Key? key,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size/2),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: 20,
      ),
    );
  }

}