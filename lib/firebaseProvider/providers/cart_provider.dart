import 'package:api/firebaseProvider/model/product_model.dart';
import 'package:flutter/material.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  List<CartItem> items = [];

  void addToCart(Product product) {
    final index = items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      items[index].quantity++;
    } else {
      items.add(CartItem(product: product));
    }

    notifyListeners();
  }

  void increaseQuantity(int index) {
    items[index].quantity++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (items[index].quantity > 1) {
      items[index].quantity--;
    } else {
      items.removeAt(index);
    }
    notifyListeners();
  }

  double get totalPrice {
    return items.fold(
        0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  void removeFromCart(int index) {}
}
