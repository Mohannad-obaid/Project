// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'big_text.dart';

class ButtonWidget extends StatelessWidget {
  late String text;
  late Color color;
  late Function onpressed;
  late double fontSize;

  ButtonWidget({Key? key,  this.color = Colors.white, required this.onpressed, this.fontSize = 20,required this.text,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
        primary: Colors.green,
       minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),

      child: BigText(
        text: text,fontSize:fontSize ,color: Colors.white,
      ),
      onPressed:(){
        onpressed();
      },
    );
  }
}
