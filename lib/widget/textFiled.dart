
// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

class TextFiledWidget extends StatelessWidget {
  late TextInputType keyboardType;
  late String hintText;
  late String valedtor;
  Function(String) onChang;
  late bool obscureText;
  late TextEditingController controller;

  TextFiledWidget({Key? key,required this.valedtor,required this.onChang, this.obscureText =false, this.keyboardType = TextInputType.text, this.hintText = 'example@gmail.com',required this.controller  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onFieldSubmitted: onChang,
      validator: (value){
        if(value!.isEmpty){
          return 'Please enter $valedtor';
        }
        return null;
      },
      keyboardType: keyboardType,
      textAlign: TextAlign.left,
      obscureText:obscureText ,
      decoration:  InputDecoration(
        fillColor: Colors.green,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 18,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
           width: 2,
          ),
        ),

      ),
    );
  }
}
