import 'package:flutter_with_sqflite_demo/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
   Database? _db;

  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_db.db');
    var myDB = openDatabase(path, version: 1, onCreate: createDb);
    return myDB;
  }

  void createDb(Database db, int version) async {
    String sql =
        'CREATE TABLE Products(id INTEGER PRIMARY KEY, name TEXT, description TEXT, unitPrice REAL)';
    await db.execute(sql);
  }

  Future<List<Product>> getProducts() async {
    Database? db = await this.db;
    var result = await db?.query("Products");
    return List.generate(
        result!.length, (index) => Product.fromObj(result[index]));
  }

  Future<Future<int>?> insert(Product product) async {
    Database? db = await this.db;

    //with rawInsert
    /*String query="INSERT INTO Products(id,name,description,unitPrice) VALUES(${product.id},${product.name},${product.description},${product.unitPrice})";
    return db.rawInsert(query);*/

    //Another way
    return db?.insert("Products", product.toMap());
  }

  Future<Future<int>?> update(Product product) async {
    Database? db = await this.db;
    /*
    return db.rawUpdate(
    'UPDATE Products SET name = ?, description = ?, unitPrice=? WHERE id = ?',
    ['updated name', 'description txt','unitPrice', 'id']);
     */
    var result = db?.update("Products", product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }

  Future<int?> delete(int id) async {
    Database? db = await this.db;
    String sql = "DELETE FROM Product where id=$id";
    var result = await _db?.rawDelete(sql);
    return result;
  }
}
