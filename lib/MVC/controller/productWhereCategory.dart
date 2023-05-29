import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductCategoryController extends ChangeNotifier {

  String category = "";

  setCategory({ required String category}){
    this.category = category;
    notifyListeners();
  }

   Future getProductCategory() async {
   return  await FirebaseFirestore.instance
       .collection('products')
       .where('category', isEqualTo: category)
       .get();
   }

  }