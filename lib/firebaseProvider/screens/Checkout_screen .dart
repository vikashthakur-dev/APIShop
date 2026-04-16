// import 'package:api/firebaseProvider/providers/order_provider.dart';
// import 'package:api/firebaseProvider/screens/Order_History_Screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/cart_provider.dart';

// class CheckoutScreen extends StatefulWidget {
//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   final name = TextEditingController();
//   final mobile = TextEditingController();
//   final address = TextEditingController();
//   final city = TextEditingController();
//   final pincode = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Delivery Address"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(15),
//         child: Column(
//           children: [
//             TextField(
//               controller: name,
//               decoration: InputDecoration(labelText: "Full Name"),
//             ),
//             TextField(
//               controller: mobile,
//               decoration: InputDecoration(labelText: "Mobile Number"),
//             ),
//             TextField(
//               controller: address,
//               decoration: InputDecoration(labelText: "Address"),
//             ),
//             TextField(
//               controller: city,
//               decoration: InputDecoration(labelText: "City"),
//             ),
//             TextField(
//               controller: pincode,
//               decoration: InputDecoration(labelText: "Pincode"),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Provider.of<OrderProvider>(context, listen: false).placeOrder(
//                   name: name.text,
//                   mobile: mobile.text,
//                   address: address.text,
//                   city: city.text,
//                   pincode: pincode.text,
//                   total: cartProvider.totalPrice,
//                 );

//                 ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Order Placed Successfully")));

//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => OrderHistoryScreen(),
//                   ),
//                 );
//               },
//               child: Text("Place Order"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// upar wala cod sahi hai ////
import 'package:api/firebaseProvider/providers/order_provider.dart';
import 'package:api/firebaseProvider/screens/Order_History_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final name = TextEditingController();
  final mobile = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final pincode = TextEditingController();

  Widget buildTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType? keyboard,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        maxLength: maxLength,
        decoration: InputDecoration(
          counterText: "",
          prefixIcon: Icon(icon, color: Colors.blue),
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// DELIVERY ADDRESS TITLE
              const Text(
                "Delivery Address",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              /// FORM CARD
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    buildTextField(
                      hint: "Full Name",
                      icon: Icons.person,
                      controller: name,
                    ),
                    buildTextField(
                      hint: "Mobile Number",
                      icon: Icons.phone,
                      controller: mobile,
                      keyboard: TextInputType.phone,
                      maxLength: 10,
                    ),
                    buildTextField(
                      hint: "Address",
                      icon: Icons.home,
                      controller: address,
                    ),
                    buildTextField(
                      hint: "City",
                      icon: Icons.location_city,
                      controller: city,
                    ),
                    buildTextField(
                      hint: "Pincode",
                      icon: Icons.pin_drop,
                      controller: pincode,
                      keyboard: TextInputType.number,
                      maxLength: 6,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// ORDER SUMMARY
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Amount",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "₹${cartProvider.totalPrice}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// PLACE ORDER BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Provider.of<OrderProvider>(context, listen: false)
                        .placeOrder(
                      name: name.text,
                      mobile: mobile.text,
                      address: address.text,
                      city: city.text,
                      pincode: pincode.text,
                      total: cartProvider.totalPrice,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Order Placed Successfully"),
                      ),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderHistoryScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Place Order",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
