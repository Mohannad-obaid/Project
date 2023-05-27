
import 'package:flutter/cupertino.dart';
import '../models/db_helper.dart';
import '../models/prodect_model.dart';

class DbController extends ChangeNotifier {

  DbController() {
    getAllStudents();
    getAllTotal();
  }


  List<ProductModel> Product = [];
  int total = 0;

 getAllTotal() {
    total = 0;
    for (var element in Product) {
      total += double.parse(element.price! as String) as int ;
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
    Product = await DbHelper.dbHelper.getAllStudents();
    flipIsLoading();
  }


  insertNewStudent(ProductModel Product) async {

    await DbHelper.dbHelper.insertNewStudent(Product);
    getAllStudents();
  }

  deleteStudent(String id) async {

    await DbHelper.dbHelper.deleteStudent(int.parse(id));
    Product.removeWhere((element) => element.idProduct == id);
    notifyListeners();
  }
}