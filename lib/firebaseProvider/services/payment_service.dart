import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  late Razorpay _razorpay;

  void initPayment() {
    _razorpay = Razorpay();
  }

  void makePayment(double amount) {
    var options = {
      'key': 'rzp_test_SDaJwqlgzLfhHs',
      'amount': (amount * 100).toInt(),
      'name': 'Shopping App',
      'currency': 'INR',
    };

    _razorpay.open(options);
  }
}
