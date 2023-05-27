import 'package:cloud_firestore/cloud_firestore.dart';
import '../MVC/models/user_model.dart';

class FirestoreController {
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('users');

  Future<bool> addToFirestore({required UserModel userModel}) async {
    return await  _collectionReference
        .doc(userModel.id)
        .set(userModel.toMap())
        .then((value) {
      return true;
    }).catchError((onError) {
      print('Error adding document');
      print(onError);
      return false;
    });
  }

  Future<bool> addProdect({required UserModel userModel}) async {
    return await  _collectionReference
        .doc(userModel.id)
        .set(userModel.toMap())
        .then((value) {
      return true;
    }).catchError((onError) {
      print('Error adding document');
      print(onError);
      return false;
    });
  }


  Future<bool> update({required UserModel userModel}) async {
    await _collectionReference
        .doc(userModel.id)
        .update(userModel.toMap())
        .then((value) => true)
        .catchError((onError) => false);
    return false;
  }




}



