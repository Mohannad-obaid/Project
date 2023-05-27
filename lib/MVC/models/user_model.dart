class UserModel{
  late String id;
  late String name;
  late String email;


  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  UserModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    email = map['email'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    return map;
  }

}