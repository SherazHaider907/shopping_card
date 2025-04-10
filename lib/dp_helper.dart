import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io'as io;
import 'package:shopping_card/card_model.dart';
class DBHelper {

  static Database? _db;
  Future<Database?> get db async {
    if(_db != null){
      return _db!;
    }
    _db = await initDatabase ();
    return _db;
  }
  initDatabase() async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,'cart.db');
    var db = await openDatabase(path ,version: 1, onCreate:_onCreate);
    return db;
  }
    _onCreate (Database db , int version )async{
    await db.execute(
      'CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT, productId VARCHAR UNIQUE, initialPrice INTEGER, productPrice INTEGER, quantity INTEGER, unitTag VARCHAR, image VARCHAR) '
    );
    }
    Future<Cart> insert(Cart cart)async{
    print(cart.toMap());
    var dbClient = await db;
    await dbClient!.insert('cart', cart.toMap());
    return cart;

    }

  Future<List<Cart>> getCartList()async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('cart');
    return queryResult.map((e)=>Cart.fromMap(e)).toList();

  }

  Future<int> delete(int id)async{
    var dbClient = await db;
    return await dbClient!.delete(
      'cart',
      where: 'id = ?',
        whereArgs: [id]
    );
  }

  Future<int> updateQuantity(Cart cart)async{
    var dbClient = await db;
    return await dbClient!.update(
        'cart',
      cart.toMap(),
      where: 'id = ?',
      whereArgs: [cart.id]
    );

  }

}
//
// //////////////
//
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'dart:io' as io;
// import 'card_model.dart';
//
// class DBHelper {
//   static Database? _db;
//
//   Future<Database?> get db async {
//     if (_db != null) return _db;
//     _db = await initDatabase();
//     return _db;
//   }
//
//   initDatabase() async {
//     io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, 'cart.db');
//     var db = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return db;
//   }
//
//   _onCreate(Database db, int version) async {
//     await db.execute(
//         'CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT, '
//             'productId VARCHAR UNIQUE, productName VARCHAR, '
//             'initialPrice INTEGER, productPrice INTEGER, '
//             'quantity INTEGER, unitTag VARCHAR, image VARCHAR)'
//     );
//   }
//
//   Future<Cart> insert(Cart cart) async {
//     var dbClient = await db;
//     await dbClient!.insert('cart', cart.toMap());
//     return cart;
//   }
//
//   Future<List<Cart>> getCartList() async {
//     var dbClient = await db;
//     final List<Map<String, Object?>> queryResult = await dbClient!.query('cart');
//     return queryResult.map((e) => Cart.fromMap(e)).toList();
//   }
// }