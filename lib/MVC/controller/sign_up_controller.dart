


import 'package:flutter/cupertino.dart';
import 'package:project01/MVC/models/user_model.dart';

import '../../Firebase/auth_firebase_Email.dart';

class SignUpController extends ChangeNotifier {



 late TextEditingController emailController = TextEditingController();
 late TextEditingController passwordController = TextEditingController();
 late TextEditingController name = TextEditingController();
 late BuildContext context ;

 final formKey = GlobalKey<FormState>();


 void onInit(){
    emailController = TextEditingController();
    passwordController = TextEditingController();
    name = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    name.dispose();
    super.dispose();
  }


  void create()async{
    if(check()) {
      bool sts = await FbAuthController().createAccount (context: context, email: emailController.text, password: passwordController.text);
      String uid = FbAuthController().userId;
      UserModel user = UserModel(name: name.text, email: emailController.text, id: uid);

      if(sts) {
        bool check = await FbAuthController().saveUser(user);
        if(check){
          clear();
          Navigator.pop(context);
        }else{
          print('error');
        }

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
    name.clear();
  }


}