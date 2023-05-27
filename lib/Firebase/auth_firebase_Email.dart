
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../MVC/models/user_model.dart';
import 'check_auth_and_active_email.dart';
import 'firestore.dart';

class FbAuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> createAccount(
      {required BuildContext context ,required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password).then((value){
        print('${value.user!.uid} is created');
        return value;
      } );


      CheckAuth().checkActiveEmail(context ,userCredential: userCredential);
      return true;
    } on FirebaseAuthException catch (e) {
      CheckAuth().controllerErrorCode(e,context);
    } catch (e) {
      print(e);
    }

    return false;
  }

  Future<bool> signIn({required BuildContext context ,required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return await CheckAuth().checkActiveEmail(context, userCredential: userCredential);
    } on FirebaseAuthException catch (e) {
      CheckAuth().controllerErrorCode(e,context);
    } catch (e) {
      print(e);
    }

    return false;
  }

  Future<void> singOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> forgetPassword({required BuildContext context,required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      CheckAuth().controllerErrorCode(e,context);
    } catch (e) {
      print(e);
    }
    return false;
  }

  bool get isLogin => _firebaseAuth.currentUser != null;
  String get userId => _firebaseAuth.currentUser!.uid;

  Future<bool> saveUser(UserModel userModel) async {
    try{
    await FirestoreController().addToFirestore(userModel: userModel );
    return true;
  }
    catch(e){
      print(e);
      return false;

    }
  }

}


