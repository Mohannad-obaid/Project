import 'package:flutter/material.dart';

mixin Helpers{
  void showSnackBar({required BuildContext context ,required String content, bool error=false }){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content,textAlign: TextAlign.center,),
        behavior: SnackBarBehavior.floating,
        backgroundColor:error ? Colors.red : Colors.green,

      ),

    );


  }
}