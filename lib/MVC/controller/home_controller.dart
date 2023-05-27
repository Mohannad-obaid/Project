import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:project01/MVC/models/prodect_model.dart';

import '../models/category_model.dart';

class HomeController extends ChangeNotifier {

  HomeController() {
    fetchProducts();
    fetchCategories();
  }

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;


  List<CategoryModel> _categories = [];
  List<CategoryModel> get Categories => _categories;

  Future<void> fetchProducts() async {
    try {
      final snapshot = FirebaseFirestore.instance.collection('products').snapshots().listen((event) {
        _products = event.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
        notifyListeners();
      });
     //.get();
     //_products = snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

    } catch (error) {
      print('Failed to fetch products: $error');
    }
  }

    Future<void> fetchCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('categories').get();
      _categories = snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
      notifyListeners();
    } catch (error) {
      print('Failed to fetch products: $error');
    }
  }
}
