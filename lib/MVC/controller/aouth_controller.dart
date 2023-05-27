import 'package:flutter/material.dart';
import '../../Firebase/auth_firebase_Email.dart';


class LoginController extends ChangeNotifier {

  late TextEditingController emailController = TextEditingController() ;
  late TextEditingController passwordController = TextEditingController() ;
   late BuildContext context ;
  final formKeyLogin = GlobalKey<FormState>();



  void login()async{
    if(check()){
      bool state =await  FbAuthController().signIn(email: emailController.text, password: passwordController.text, context: context);
      if(state){
        clear();
        Navigator.pushReplacementNamed(context, '/');
      }


    }
  }

  bool check(){
    if(passwordController.text.isNotEmpty && emailController.text.isNotEmpty){
      return true;
    }
    return false;
  }

  void clear(){
   emailController.clear();
   passwordController.clear();
  }

  Future<void> logOut() async {
    await FbAuthController().singOut();
  }


}