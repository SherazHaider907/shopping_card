import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_card/card_model.dart';
import 'package:shopping_card/card_provider.dart';
import 'package:shopping_card/dp_helper.dart';

import 'card_screen.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<String> productNames = [
    'Apple',
    'Mango',
    'Banana',
    'Orange',
    'Strawberry',
    'Pineapple',
    'Grapes',
  ];
  List<String> productUnits = [
    'Kg',
    'Kg',
    'Dozen',
    'Kg',
    'Gram',
    'Piece',
    'Kg',
  ];
  List<int> productPrices = [33, 44, 29, 37, 59, 19, 24];
  List<String> productImages = [
    "https://t3.ftcdn.net/jpg/09/95/55/48/240_F_995554847_v8Qh3WvXwyo9neIde23B166lFWm3l5Ha.jpg",
    "https://t3.ftcdn.net/jpg/11/99/91/62/240_F_1199916269_UAsfQg97ju6SpMGzkkZVWSn19jX0sGhV.jpg",
    "https://t3.ftcdn.net/jpg/10/08/02/02/240_F_1008020241_YP3x2spstRKtZKwAQY2ZqJ0sLOySXdUB.jpg",
    "https://t4.ftcdn.net/jpg/09/48/32/95/240_F_948329554_8kG5ix2y1oxJycBweCbGg1Yp4VDg6C2G.jpg",
    "https://t3.ftcdn.net/jpg/04/53/05/84/240_F_453058430_Vfkmw5SgdLINaWP9g5rLVlEWMkRmzlrZ.jpg",
    "https://t4.ftcdn.net/jpg/12/85/84/65/240_F_1285846505_aPAYiIpPIk6blKg8l97w8HAecLcOKfTk.jpg",
    "https://t3.ftcdn.net/jpg/12/87/46/32/240_F_1287463249_VIIci3SLDS4R7nWVTKeFmxUfc6AfWiCw.jpg",
  ];

  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Product List'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CardScreen()),
              );
            },
            child: Center(
              child: badges.Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.getCounter().toString(),
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
                badgeAnimation: badges.BadgeAnimation.slide(
                  animationDuration: Duration(milliseconds: 300),
                ),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productNames.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image(
                              height: 100,
                              width: 100,
                              image: NetworkImage(
                                productImages[index].toString(),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productNames[index].toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    productUnits[index].toString() +
                                        " " +
                                        r'$' +
                                        productPrices[index].toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () async {
                                        try {
                                          await dbHelper!.insert(
                                            Cart(
                                              id: index,
                                              productId: index.toString(),
                                              initialPrice:
                                                  productPrices[index],
                                              productPrice:
                                                  productPrices[index],
                                              quantity: 1,
                                              unitTag:
                                                  productUnits[index]
                                                      .toString(),
                                              image:
                                                  productImages[index]
                                                      .toString(),
                                              productName:
                                                  productNames[index]
                                                      .toString(),
                                            ),
                                          );
                                          print("Product Added To Cart");
                                          cart.addTotalPrice(
                                            productPrices[index].toDouble(),
                                          ); // Simplify conversion
                                          cart.addCounter();
                                        } catch (error) {
                                          print("Error: ${error.toString()}");
                                        }
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Add To Card",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}





///////////////////

// import 'package:flutter/material.dart';
// import 'package:badges/badges.dart' as badges;
// import 'package:provider/provider.dart';
// import 'card_model.dart';
// import 'card_provider.dart';
// // import 'db_helper.dart';
// import 'dp_helper.dart';
//
// class ProductList extends StatefulWidget {
//   const ProductList({super.key});
//
//   @override
//   State<ProductList> createState() => _ProductListState();
// }
//
// class _ProductListState extends State<ProductList> {
//   final List<String> productNames = [
//     'Apple', 'Mango', 'Banana', 'Orange',
//     'Strawberry', 'Pineapple', 'Grapes'
//   ];
//   final List<String> productUnits = [
//     'Kg', 'Kg', 'Dozen', 'Kg', 'Gram', 'Piece', 'Kg'
//   ];
//   final List<int> productPrices = [33, 44, 29, 37, 59, 19, 24];
//   final List<String> productImages = [
//     "https://t3.ftcdn.net/jpg/09/95/55/48/240_F_995554847_v8Qh3WvXwyo9neIde23B166lFWm3l5Ha.jpg",
//     "https://t3.ftcdn.net/jpg/11/99/91/62/240_F_1199916269_UAsfQg97ju6SpMGzkkZVWSn19jX0sGhV.jpg",
//     "https://t3.ftcdn.net/jpg/10/08/02/02/240_F_1008020241_YP3x2spstRKtZKwAQY2ZqJ0sLOySXdUB.jpg",
//     "https://t4.ftcdn.net/jpg/09/48/32/95/240_F_948329554_8kG5ix2y1oxJycBweCbGg1Yp4VDg6C2G.jpg",
//     "https://t3.ftcdn.net/jpg/04/53/05/84/240_F_453058430_Vfkmw5SgdLINaWP9g5rLVlEWMkRmzlrZ.jpg",
//     "https://t4.ftcdn.net/jpg/12/85/84/65/240_F_1285846505_aPAYiIpPIk6blKg8l97w8HAecLcOKfTk.jpg",
//     "https://t3.ftcdn.net/jpg/12/87/46/32/240_F_1287463249_VIIci3SLDS4R7nWVTKeFmxUfc6AfWiCw.jpg",
//   ];
//
//   final DBHelper dbHelper = DBHelper();
//
//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product List'),
//         centerTitle: true,
//         actions: [
//           badges.Badge(
//             badgeContent: Consumer<CartProvider>(
//               builder: (context, value, child) => Text(
//                 value.counter.toString(),
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//             child: const Icon(Icons.shopping_bag_outlined),
//           ),
//           const SizedBox(width: 20),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: productNames.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Image.network(
//                     productImages[index],
//                     height: 100,
//                     width: 100,
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           productNames[index],
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Text(
//                           '${productUnits[index]} \$${productPrices[index]}',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: InkWell(
//                             onTap: () async {
//                               try {
//                                 await dbHelper.insert(
//                                   Cart(
//                                     productId: DateTime.now()
//                                         .millisecondsSinceEpoch
//                                         .toString(),
//                                     initialPrice: productPrices[index],
//                                     productPrice: productPrices[index],
//                                     quantity: 1,
//                                     unitTag: productUnits[index],
//                                     image: productImages[index],
//                                     productName: productNames[index],
//                                   ),
//                                 );
//                                 cart.addCounter();
//                                 cart.addTotalPrice(
//                                     productPrices[index].toDouble());
//                                 cart.refreshCart();
//                               } catch (error) {
//                                 print("Error: $error");
//                               }
//                             },
//                             child: Container(
//                               height: 35,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                 color: Colors.green,
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                               child: const Center(
//                                 child: Text(
//                                   "Add To Cart",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
