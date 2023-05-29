import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
   String? id;
   String? name;
   double? price;
   String? image;
   String? description;
   String? category;

  ProductModel(
      {
        this.id,
        required this.name,
        required this.price,
        required this.image,
        required this.description,
        required this.category
      });

   factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
     return ProductModel(
        id: data['id'],
       name: data['name'] ,
       price: data['price'],
       image: data['image'] ,
       description: data['description'] ,
        category: data['category'] ,
     );
   }



  ProductModel.fromMap(Map rowMap) {
    id = rowMap['id'];
    name = rowMap['name'];
    price = rowMap['price'].toDouble() ;
    image = rowMap['image'];
    description = rowMap['description'];
    category = rowMap['category'];

  }

    toMap() {
    return {
      'id': id,
      'name': name,
      'price': price ,
      'image': image,
      'description': description,
      'category': category,
    };
  }
}
