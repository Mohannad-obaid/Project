import 'package:flutter/cupertino.dart';
import 'package:project01/MVC/models/prodect_model.dart';
import 'db_conrtoller.dart';


class ProductController extends ChangeNotifier  {

  List<ProductModel> productsCart = <ProductModel>[];

  Future<bool> addToCart({required ProductModel productModel}) async{
    int id = await DbController().insertNewStudent(productModel);
    if(id  != 0){
      return true;
    }
    return false;
  }


  Future<void> addProductToCart(ProductModel productModel) async {
    try{
      bool state = await addToCart(productModel: productModel);
      if (state) {
        print('Success');
      }else{
        print('Failed');
      }
    }
    catch(e){
      print(e);
    }
  }




}