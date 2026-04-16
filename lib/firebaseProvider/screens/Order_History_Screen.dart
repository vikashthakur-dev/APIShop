// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/order_provider.dart';

// class OrderHistoryScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final orderProvider = Provider.of<OrderProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Order History"),
//       ),
//       body: orderProvider.orders.isEmpty
//           ? Center(child: Text("No Orders Yet"))
//           : ListView.builder(
//               itemCount: orderProvider.orders.length,
//               itemBuilder: (context, index) {
//                 final order = orderProvider.orders[index];

//                 return Card(
//                   margin: EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text(order.name),
//                     subtitle: Text(
//                         "${order.address}, ${order.city} - ${order.pincode}"),
//                     trailing: Text("₹${order.totalPrice}"),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

//// upar wala code sahi hai ////
///

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: orderProvider.orders.isEmpty
          ? const Center(
              child: Text(
                "No Orders Yet",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: orderProvider.orders.length,
              itemBuilder: (context, index) {
                final order = orderProvider.orders[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// NAME
                      Row(
                        children: [
                          const Icon(Icons.person, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            order.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      /// MOBILE
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 18),
                          const SizedBox(width: 6),
                          Text(order.mobile),
                        ],
                      ),

                      const SizedBox(height: 8),

                      /// ADDRESS
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, size: 18),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              "${order.address}, ${order.city} - ${order.pincode}",
                            ),
                          ),
                        ],
                      ),

                      const Divider(height: 20),

                      /// PRICE + DATE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹${order.totalPrice}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            "${order.date.day}/${order.date.month}/${order.date.year}",
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
