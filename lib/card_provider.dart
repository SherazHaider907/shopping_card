import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_card/dp_helper.dart';
import 'card_model.dart';
import 'dp_helper.dart';

class CartProvider with ChangeNotifier {
  DBHelper? dbHelper = DBHelper();
  int _counter = 0;
  int get counter => _counter;

  double _price = 0.0;
  double get price => _price;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getCart() async {
    _cart = dbHelper!.getCartList();
    return _cart;
  }

  void _setPrefItems ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('cart_price', _price);
    notifyListeners();

  }

  void _getPrefItems ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _price = prefs.getDouble('cart_price')?? 0.0;
    notifyListeners();

  }

  void addTotalPrice(double productprice){
    _price = _price + productprice;
    _setPrefItems();
    notifyListeners();

  }
  void removeTotalPrice(double productprice){
    _price = _price - productprice;
    _setPrefItems();
    notifyListeners();
  }

  double get totalPrice{
    _getPrefItems();
    return _price;
  }


  void addCounter()async{
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter()async{
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter(){
    _getPrefItems();
    return _counter;

  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'db_helper.dart';
// import 'card_model.dart';
// import 'dp_helper.dart';
//
// class CartProvider with ChangeNotifier {
//   final DBHelper dbHelper = DBHelper();
//   int _counter = 0;
//   double _price = 0.0;
//   late Future<List<Cart>> _cart;
//
//   int get counter => _counter;
//   double get price => _price;
//   Future<List<Cart>> get cart => _cart;
//
//   CartProvider() {
//     _initialize();
//   }
//
//   void _initialize() async {
//     await _getPrefItems();
//     _cart = dbHelper.getCartList();
//     notifyListeners();
//   }
//
//   Future<void> _setPrefItems() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setInt('cart_item', _counter);
//     prefs.setDouble('cart_price', _price);
//   }
//
//   Future<void> _getPrefItems() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _counter = prefs.getInt('cart_item') ?? 0;
//     _price = prefs.getDouble('cart_price') ?? 0.0;
//     notifyListeners();
//   }
//
//   void addTotalPrice(double productPrice) {
//     _price += productPrice;
//     _setPrefItems();
//     notifyListeners();
//   }
//
//   void removeTotalPrice(double productPrice) {
//     _price -= productPrice;
//     _setPrefItems();
//     notifyListeners();
//   }
//
//   void addCounter() {
//     _counter++;
//     _setPrefItems();
//     notifyListeners();
//   }
//
//   void removeCounter() {
//     _counter--;
//     _setPrefItems();
//     notifyListeners();
//   }
//
//   Future<void> refreshCart() async {
//     _cart = dbHelper.getCartList();
//     notifyListeners();
//   }
// }