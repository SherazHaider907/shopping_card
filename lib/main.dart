import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_card/product_list.dart';

import 'card_provider.dart' show CartProvider;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create:
    (_)=>CartProvider(),
      child: Builder(builder: (BuildContext context){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shopping_Card',
          theme: ThemeData(


            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          home:const ProductList(),
        );
      }),
    );
  }
}
