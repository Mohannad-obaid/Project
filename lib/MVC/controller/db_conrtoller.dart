
import 'package:flutter/cupertino.dart';
import '../models/db_helper.dart';
import '../models/prodect_model.dart';

class DbController extends ChangeNotifier {

  DbController() {
    getAllStudents();
    getAllTotal();
  }


  List<ProductModel> Product = [];
  double total = 0;

 getAllTotal() {
    for (var element in Product) {
      total += element.price!  ;
    }
    notifyListeners();
  }

  bool isLoading = false;

  flipIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  getAllStudents() async {
    flipIsLoading();
    Product = await DbHelper.dbHelper.getAllProduct();
    Product.forEach((element) {
      print(element.name);
    });
    getAllTotal();
    flipIsLoading();

  }


  insertNewStudent(ProductModel Product) async {

    await DbHelper.dbHelper.insertNewStudent(Product);
    getAllStudents();
  }

  deleteStudent(String id) async {

    await DbHelper.dbHelper.deleteProduct(id);
    Product.removeWhere((element) => element.id == id);
    getAllTotal();
    notifyListeners();
  }
}