import 'package:api/firebaseProvider/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> orders = [];

  void placeOrder({
    required String name,
    required String mobile,
    required String address,
    required String city,
    required String pincode,
    required double total,
  }) {
    orders.add(
      Order(
        id: DateTime.now().toString(),
        name: name,
        mobile: mobile,
        address: address,
        city: city,
        pincode: pincode,
        totalPrice: total,
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
