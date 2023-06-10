
import 'package:flutter_with_sqflite_demo/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {

  late Database _db;

  Future<Database> get db async{
    _db ??= await initializeDb();
    return _db;
  }
  Future<Database> initializeDb() async{
    var databasesPath= await getDatabasesPath();
    String path=join(databasesPath,'my_db.db');
    var myDB=openDatabase(path,version: 1, onCreate: createDb);
    return myDB;
  }
  void createDb(Database db, int version) async{
    String sql='CREATE TABLE Products(id INTEGER PRIMARY KEY, name TEXT, description TEXT, unitPrice REAL)';
    await db.execute(sql);
  }


}