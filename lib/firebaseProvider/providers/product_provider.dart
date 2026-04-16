import 'package:api/firebaseProvider/model/product_model.dart';
import 'package:api/firebaseProvider/services/api_service.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  List<Product> filteredProducts = [];

  bool isLoading = false;

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    products = await ApiService().fetchProducts();
    filteredProducts = products;

    isLoading = false;
    notifyListeners();
  }

  void searchProduct(String query) {
    if (query.isEmpty) {
      filteredProducts = products;
    } else {
      filteredProducts = products
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }
}

// import 'package:api/firebaseProvider/model/product_model.dart';
// import 'package:flutter/material.dart';

// import '../services/api_service.dart';

// class ProductProvider extends ChangeNotifier {
//   List<Product> products = [];
//   bool isLoading = false;

//   Future<void> loadProducts() async {
//     isLoading = true;
//     notifyListeners();

//    // products = await ApiService().fetchProducts();
//    products = await ApiService().fetchProducts();
// filteredProducts = products;

//     isLoading = false;
//     notifyListeners();
//   }
//   List<Product> filteredProducts = [];

// void searchProduct(String query) {
//   if (query.isEmpty) {
//     filteredProducts = products;
//   } else {
//     filteredProducts = products
//         .where((product) =>
//             product.title.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }

//   notifyListeners();
// }
// }
