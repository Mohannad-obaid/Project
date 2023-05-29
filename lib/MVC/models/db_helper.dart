import 'dart:developer';

import 'package:project01/MVC/models/prodect_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {

  static const String tableName = 'products';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnPrice = 'price';
  static const columnImage = 'image';
  static const columnDescription = 'description';


  DbHelper._();
  static DbHelper dbHelper = DbHelper._();
  late Database database;


  initDatabase() async {
    String appPath = await getDatabasesPath();
    String dbPath = '$appPath/flutter_course.db';
    database = await openDatabase(dbPath, version: 1, onCreate: (db, v) {
      db.execute(
          'CREATE TABLE products (id TEXT PRIMARY KEY NOT NULL, name TEXT, price DOUBLE, image TEXT , description TEXT,category TEXT)');
    });
  }

  insertNewStudent(ProductModel prodectModel ) async {
    try {
      int rowNumber = await database.insert(tableName, prodectModel.toMap());
      log(rowNumber.toString());
      log("row has been inserted");
    } catch (e) {
      log("row has not been inserted");
      log(e.toString());
    }
  }

  Future<List<ProductModel>> getAllProduct() async {
    await Future.delayed(const Duration(seconds: 3));
    List<Map> results = await database.query('products');
    List<ProductModel> product = results.map((e) => ProductModel.fromMap(e)).toList();
    return product;
  }

  Future<ProductModel> getStudentById(int id) async {
    List<Map> results = await database.query(tableName, where: 'id=$id');
    return ProductModel.fromMap(results.first);
  }

  deleteProduct(String id) async {
    await database.delete(tableName, where: 'id=$id');
  }

}


/*
 initDatabase() async {
    String appPath = await getDatabasesPath();
    String dbPath = appPath + '/flutter_course.db';
    database = await openDatabase(dbPath, version: 2, onCreate: (db, v) async {
      await db.execute('''
          CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnIdProduct TEXT NOT NULL,
        $columnName TEXT NOT NULL,
        $columnPrice REAL NOT NULL,
        $columnImage TEXT NOT NULL,
        $columnDescription TEXT NOT NULL
      )
        '''
          );
    });
  }
 */