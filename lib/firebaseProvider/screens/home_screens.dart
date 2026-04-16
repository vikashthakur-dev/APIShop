// /////

// import 'package:api/firebaseProvider/screens/cart_screens.dart';
// import 'package:api/firebaseProvider/screens/detail_screens.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/product_provider.dart';
// import '../providers/cart_provider.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   // int selected = 0;
//   // @override

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       Provider.of<ProductProvider>(context, listen: false).loadProducts();
//     });
//   }
//   // void initState() {
//   //   super.initState();
//   //   Provider.of<ProductProvider>(context, listen: false).loadProducts();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
//     final cartProvider = Provider.of<CartProvider>(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: TextField(
//           onChanged: (value) {
//             Provider.of<ProductProvider>(context, listen: false)
//                 .searchProduct(value);
//           },
//           decoration: InputDecoration(
//             hintText: "Search Product",
//             border: InputBorder.none,
//             icon: Icon(Icons.search),
//           ),
//         ),
//         // title: TextField(
//         //   decoration: InputDecoration(
//         //     hintText: "Search Product",
//         //     border: InputBorder.none,
//         //     icon: Icon(Icons.search),
//         //   ),
//         // ),

//         // title: Text("Products"),
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.shopping_cart),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => CartScreen()),
//                   );
//                 },
//               ),
//               if (cartProvider.totalItems > 0)
//                 Positioned(
//                   right: 5,
//                   top: 5,
//                   child: Container(
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                         color: Colors.red, shape: BoxShape.circle),
//                     child: Text(
//                       cartProvider.totalItems.toString(),
//                       style: TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                   ),
//                 )
//             ],
//           )
//         ],
//       ),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   selectedItemColor: Colors.white,
//       //   currentIndex: selected,
//       //   onTap: (value) {
//       //     setState(() {
//       //       selected = value;
//       //     });

//       //     if (selected == 1) {
//       //       Navigator.push(
//       //           context, MaterialPageRoute(builder: (context) => CartScreen()));
//       //     }
//       //     if (selected == 2) {
//       //       Navigator.push(context,
//       //           MaterialPageRoute(builder: (context) => OrderScreen()));
//       //     }
//       //   },
//       //   backgroundColor: Colors.red,
//       //   items: const [
//       //     BottomNavigationBarItem(
//       //       backgroundColor: Colors.red,
//       //       icon: Icon(Icons.home),
//       //       label: "Home",
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.shopping_cart),
//       //       label: "Cart",
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.person),
//       //       label: "Profile",
//       //     ),
//       //   ],
//       // ),
//       body: productProvider.isLoading
//           ? Center(child: CircularProgressIndicator())
//           : GridView.builder(
//               // itemCount: productProvider.products.length,
//               itemCount: productProvider.filteredProducts.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.8,
//               ),
//               itemBuilder: (context, index) {
//                 //final product = productProvider.products[index];
//                 final product = productProvider.filteredProducts[index];

//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => DetailScreen(product: product)),
//                     );
//                   },
//                   child: Card(
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: Image.network(
//                             product.image,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 5),
//                           child: Text(
//                             product.title,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           // child: Text(product.title),
//                         ),
//                         Text("₹${product.price}"),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

/////  upar wala sahi hai /////

import 'package:api/firebaseProvider/screens/cart_screens.dart';
import 'package:api/firebaseProvider/screens/detail_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            // textAlignVertical: TextAlignVertical.center,
            onChanged: (value) {
              context.read<ProductProvider>().searchProduct(value);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 4,
              ),
              hintText: "Search Product...",
              hintStyle: TextStyle(fontSize: 17),
              border: InputBorder.none,
              //prefixIcon: Icon(Icons.search, color: Colors.grey),
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartScreen()),
                  );
                },
              ),
              if (cartProvider.totalItems > 0)
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartProvider.totalItems.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
            ],
          )
        ],
      ),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: productProvider.filteredProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = productProvider.filteredProducts[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(product: product),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// PRODUCT IMAGE
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.network(
                              product.image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 8.0),
                          child: Text(
                            product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "₹${product.price}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ),

                        SizedBox(height: 6)
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
