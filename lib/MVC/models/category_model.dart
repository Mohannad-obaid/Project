
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  late String id;
  late String name;
  late String image;

  CategoryModel({ required this.id, required this.name, required this.image});

  CategoryModel.fromMap(Map<String, dynamic> map) {

    id = map['id'];
    name = map['name'];
    image = map['image'];

  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id']    =  id;
    map['name']  =  name;
    map['image'] =  image;
    return map;
  }

  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return CategoryModel(
      id: snapshot.id,
      name: data['name'] as String,
      image: data['image'] as String,
    );
  }


}