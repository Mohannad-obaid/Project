import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../Firebase/auth_firebase_Email.dart';
import '../../utils/helper.dart';

class ProfileController extends ChangeNotifier with Helpers  {
  bool isDark = false;
  XFile? pickedFile;
  double? _indicatorValue = 0;
  ImagePicker imagePicker = ImagePicker();
  final storageRef = FirebaseStorage.instance.ref().child('images/');
  String? _imageUrl;
  File? file;

  late BuildContext context;

  CollectionReference userRef   = FirebaseFirestore.instance.collection('users');


  void changeTheme() {
    isDark = !isDark;
    notifyListeners();
  }

  getTheme() => isDark;

 Future<DocumentSnapshot<Map<String, dynamic>>?> getProfileData() async {
    return await FirebaseFirestore.instance.collection('users').doc(FbAuthController().userId).get();
  }


  Future updateImageProfile(String urlImage ) async {
    String? id =  FbAuthController().userId;
      userRef.doc(id).update({
        'image': urlImage,
      }).then((value) =>
      showSnackBar(
          context: context,
          content: 'تم تحديث الصورة بنجاح',
          error: false)
      )
          .catchError((error) =>
      showSnackBar(
          context: context,
          content: 'حدث خطأ ما',
          error: true));

  }



  Future<bool> pickImage() async {
    try {
      pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
          pickedFile = pickedFile;
          notifyListeners();
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {

          file = File(result.files.single.path!);
          notifyListeners();

      }else{
        showSnackBar(
            context: context,
            content: 'No internet connection',
            error: true);



      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void uploadImage({required File file, required void Function(bool state, TaskState status, String message)eventHandler}) {
    try {
      UploadTask uploadTask =
      storageRef.child("image_${FbAuthController().userId}").putFile(file);
      _imageUrl = uploadTask.snapshot.ref.getDownloadURL().then((value) async => {
       await updateImageProfile(value),
        print(value),
      } ).toString();

        _imageUrl = _imageUrl;
        notifyListeners();

      uploadTask.snapshotEvents.listen((event) {
        if (event.state == TaskState.running) {
          print('running');
          eventHandler(false, event.state, '');
        } else if (event.state == TaskState.success) {
          print('success');
          eventHandler(true, event.state, 'Upload Image Successfully');
        } else if (event.state == TaskState.error) {
          print('error');
          eventHandler(false, event.state, 'Upload Image Failed');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void uoloadImage() async {
    if (_indicatorValue != null) {
      // await  pickImage();
      try {
        uploadImage(
            file: File(pickedFile!.path),
            eventHandler: (status, TaskState state, message) {
              if (status) {
                //upload successfully
                changeIndicatorValue(1);
                showSnackBar(context: context, content: "Pick image to uploada!", error: false);
              } else if (state == TaskState.running) {
                //uploading
              } else {
                changeIndicatorValue(0);
                showSnackBar(context: context, content: message, error: true);
              }
            });
      } catch (e) {
        showSnackBar(
            context: context, content: 'Pick image to uploada!', error: true);
      }
    } else {
      showSnackBar(
          context: context, content: 'Pick image to uploada!', error: true);
    }
  }

  void uoloadFile() async {
    if (_indicatorValue != null) {
      // await  pickImage();
      try {
        uploadImage(
            file: file!,
            eventHandler: (status, TaskState state, message) {
              if (status) {
                //upload successfully
                changeIndicatorValue(1);
                showSnackBar(context: context, content: message, error: false);
              } else if (state == TaskState.running) {
                //uploading
              } else {
                changeIndicatorValue(0);
                showSnackBar(context: context, content: message, error: true);
              }
            });
      } catch (e) {
        showSnackBar(context: context, content: 'Pick image to uploada!', error: true);
      }
    } else {
      showSnackBar(context: context, content: 'Pick image to uploada!', error: true);
    }
  }

  void changeIndicatorValue(double? value) {

      _indicatorValue = value;
      notifyListeners();

  }
}