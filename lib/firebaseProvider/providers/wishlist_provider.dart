import 'package:api/firebaseProvider/model/product_model.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  List<Product> wishlist = [];

  void toggleWishlist(Product product) {
    if (wishlist.contains(product)) {
      wishlist.remove(product);
    } else {
      wishlist.add(product);
    }

    notifyListeners();
  }

  bool isExist(Product product) {
    return wishlist.contains(product);
  }
}
