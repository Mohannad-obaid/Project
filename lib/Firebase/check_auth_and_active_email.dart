import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/helper.dart';




class CheckAuth with Helpers{
  final FirebaseAuth  _firebaseAuth = FirebaseAuth.instance;


  Future<bool> checkActiveEmail(BuildContext context,{required UserCredential userCredential})async{
    if(! userCredential.user!.emailVerified){
      userCredential.user!.sendEmailVerification();
      showSnackBar(context: context, content: 'الرجاء تفعيل الايميل');
      return false;
    }
    return true;
  }


  void controllerErrorCode(FirebaseAuthException authException,BuildContext context)  {
    switch (authException.code) {
      case 'email-already-in-use':
        showSnackBar(
            context: context,
            content: 'هذا الايميل مستخدم بالفعل',
            error: true);
        break;

      case 'invalid-email':
        showSnackBar(context: context, content: 'إيميل غير صالح', error: true);
        break;

      case 'operation-not-allowed':
        break;

      case 'weak-password':
        showSnackBar(context: context, content: 'كلمة مرور ضعيفة', error: true);
        break;

      case 'user-not-found':
        showSnackBar(
            context: context,
            content: 'لا يوجد مستخدم بهذا الايميل',
            error: true);
        break;
      case 'wrong-password':
        showSnackBar(context: context, content: 'كلمة مرور خاطئة', error: true);
        break;

      case 'network-request-failed':
        showSnackBar(
            context: context,
            content: 'الرجاء التحقق من الاتصال بالانترنت',
            error: true);
        break;

    default:
      showSnackBar(context: context, content:'الرجاء التحقق من الاتصال بالانترنت',error:true);
      print("error code: ${authException.code}");
      print(authException.code);
      break;

    }
  }

}