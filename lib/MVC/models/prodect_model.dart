import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
   int? id;
   String? idProduct;
   String? name;
   double? price;
   String? image;
   String? description;

  ProductModel(
      {
        this.id,
        this.idProduct,
        required this.name,
        required this.price,
        required this.image,
        required this.description
      });

   factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
     return ProductModel(
       idProduct: snapshot.id,
       name: data['name'] as String,
       price: data['price'],
       image: data['image'] as String,
       description: data['description'] as String,
     );
   }



  ProductModel.fromMap(Map rowMap) {

    idProduct = rowMap['idProduct'];
    name = rowMap['name'];
    description = rowMap['description'];
    price = rowMap['price'] != null ? double.parse(rowMap['price']) : null;
    image = rowMap['image'];
  }

    toMap() {
    return {
      'idProduct': idProduct,
      'name': name,
      'price': price ,
      'image': image,
      'description': description,
    };
  }
}
