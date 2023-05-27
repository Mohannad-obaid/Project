import 'dart:developer';

import 'package:project01/MVC/models/prodect_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {

  static const String tableName = 'products';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnPrice = 'price';
  static const String columnImage = 'image';
  static const String columnDescription = 'description';

  DbHelper._();
  static DbHelper dbHelper = DbHelper._();
  late Database database;
  initDatabase() async {
    String appPath = await getDatabasesPath();
    String dbPath = appPath + '/flutter_course.db';
    database = await openDatabase(dbPath, version: 2, onCreate: (db, v) {
      db.execute('''
          CREATE TABLE $tableName ($columnId TEXT NOT NULL,
          $columnName TEXT NOT NULL,
          $columnPrice TEXT NOT NULL,
          $columnImage TEXT NOT NULL,
          $columnDescription TEXT NOT NULL);
        '''
          );
    });
  }

  insertNewStudent(ProductModel prodectModel ) async {
    try {
      print(prodectModel.toMap());
      print('******');
      int rowNumber = await database.insert(tableName, prodectModel.toMap());
      log(rowNumber.toString());
    } catch (e) {
      log("row has not been inserted");
    }
  }

  Future<List<ProductModel>> getAllStudents() async {
    await Future.delayed(const Duration(seconds: 3));
    List<Map> results = await database.query(tableName);
    List<ProductModel> prodect = results.map((e) => ProductModel.fromMap(e)).toList();
    return prodect;
  }

  Future<ProductModel> getStudentById(int id) async {
    List<Map> results = await database.query(tableName, where: 'id=$id');
    return ProductModel.fromMap(results.first);
  }

  deleteStudent(int id) async {
    await database.delete(tableName, where: 'id=$id');
  }

  updateStudent(ProductModel product) async {
    await database.update(tableName, product.toMap(),
        where: 'id=${product.idProduct}');
  }
}