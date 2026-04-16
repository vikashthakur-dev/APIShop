import 'package:api/firebaseProvider/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../providers/cart_provider.dart';

class DetailScreen extends StatefulWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentIndex = 0;
  late Razorpay _razorpay;

  /// 🔥 Multiple images (Demo)
  List<String> images = [];

  @override
  void initState() {
    super.initState();

    images = [
      widget.product.image,
      widget.product.image,
      widget.product.image,
      widget.product.image,
    ];

    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout(int amount) {
    var options = {
      'key': 'rzp_test_SDaJwqlgzLfhHs',
      'amount': amount * 100,
      'name': 'Vikash Store',
      'description': widget.product.title,
      'prefill': {'contact': '9876543210', 'email': 'vikash753055@gmail.com'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Successful ✅")),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Failed ❌")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("External Wallet Selected")),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 IMAGE SLIDER
            CarouselSlider(
              options: CarouselOptions(
                height: 320,
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: images.map((imageUrl) {
                return InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),

            /// 🔥 DOT INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        currentIndex == entry.key ? Colors.black : Colors.grey,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            /// 🔥 PRODUCT TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.product.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// 🔥 PRICE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "₹${widget.product.price}",
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// ⭐ RATING UI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  Icon(Icons.star, color: Colors.orange),
                  Icon(Icons.star, color: Colors.orange),
                  Icon(Icons.star, color: Colors.orange),
                  Icon(Icons.star, color: Colors.orange),
                  Icon(Icons.star_half, color: Colors.orange),
                  SizedBox(width: 8),
                  Text("(4.5 Rating)")
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 📄 DESCRIPTION
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Product Description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "This is a high quality product. It is designed with premium material and best performance. Perfect for daily use.",
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            /// 🛒 ADD TO CART + BUY NOW
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        cart.addToCart(widget.product);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added to Cart"),
                          ),
                        );
                      },
                      child: const Text("Add to Cart"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        openCheckout(widget.product.price.toInt());
                      },
                      child: const Text("Buy Now"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}















///// yah bhui sahi code hai //////



// import 'package:api/firebaseProvider/model/product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// import '../providers/cart_provider.dart';

// class DetailScreen extends StatefulWidget {
//   final Product product;

//   const DetailScreen({super.key, required this.product});

//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   late Razorpay _razorpay;

//   @override
//   void initState() {
//     super.initState();

//     _razorpay = Razorpay();

//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   void openCheckout(int amount) {
//     var options = {
//       'key': 'rzp_test_SDaJwqlgzLfhHs',
//       'amount': amount * 100,
//       'name': 'Vikash Store',
//       'description': widget.product.title,
//       'prefill': {'contact': '9876543210', 'email': 'vikash753055@gmail.com'}
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Payment Successful ✅")),
//     );
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Payment Failed ❌")),
//     );
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("External Wallet Selected")),
//     );
//   }

//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cart = context.read<CartProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.product.title),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 350,
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => FullScreenImage(
//                         imageUrl: widget.product.image,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.all(12),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Image.network(
//                       widget.product.image,
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             /// 🔥 IMAGE SLIDER (Even if 1 image, safe rahega)
//             // CarouselSlider(
//             //   options: CarouselOptions(
//             //     height: 320,
//             //     enlargeCenterPage: true,
//             //     enableInfiniteScroll: false,
//             //   ),
//             //   items: [widget.product.image].map((imageUrl) {
//             //     return Container(
//             //       margin: const EdgeInsets.all(8),
//             //       child: ClipRRect(
//             //         borderRadius: BorderRadius.circular(15),
//             //         child: InteractiveViewer(
//             //           child: Image.network(
//             //             imageUrl,
//             //             fit: BoxFit.cover,
//             //             width: double.infinity,
//             //           ),
//             //         ),
//             //       ),
//             //     );
//             //   }).toList(),
//             // ),

//             const SizedBox(height: 20),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 widget.product.title,
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 10),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 "₹${widget.product.price}",
//                 style: const TextStyle(
//                   fontSize: 20,
//                   color: Colors.green,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   /// 🟢 ADD TO CART
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                       onPressed: () {
//                         cart.addToCart(widget.product);

//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("Added to Cart"),
//                           ),
//                         );
//                       },
//                       child: const Text("Add to Cart"),
//                     ),
//                   ),

//                   const SizedBox(width: 10),

//                   /// 🔵 BUY NOW
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                       onPressed: () {
//                         openCheckout(widget.product.price.toInt());
//                       },
//                       child: const Text("Buy Now"),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
// }

 

// //////////

// class FullScreenImage extends StatelessWidget {
//   final String imageUrl;

//   const FullScreenImage({super.key, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: GestureDetector(
//         onTap: () => Navigator.pop(context),
//         child: Center(
//           child: InteractiveViewer(
//             minScale: 1,
//             maxScale: 5,
//             child: Image.network(imageUrl),
//           ),
//         ),
//       ),
//     );
//   }
// }






/// yah sahi hai 

// import 'package:api/firebaseProvider/model/product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// import '../providers/cart_provider.dart';

// class DetailScreen extends StatefulWidget {
//   final Product product;

//   DetailScreen({required this.product});
//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   late Razorpay _razorpay;

//   @override
//   void initState() {
//     super.initState();

//     _razorpay = Razorpay();

//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   // 🔵 RAZORPAY OPEN
//   void openCheckout(int amount) {
//     var options = {
//       'key': 'rzp_test_SDaJwqlgzLfhHs', // 🔥 apna test key yaha lagana
//       'amount': amount * 100,
//       'name': 'Vikash Store',
//       'description': widget.product.title,
//       'prefill': {'contact': '9876543210', 'email': 'vikash753055@gmail.com'}
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print(e);
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Payment Successful ✅")),
//     );
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Payment Failed ❌")),
//     );
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("External Wallet Selected")),
//     );
//   }

//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cart = context.read<CartProvider>();

//     return Scaffold(
//       appBar: AppBar(title: Text(widget.product.title)),
//       body: Column(
//         children: [
//           Expanded(
//             child: Image.network(widget.product.image),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             "₹${widget.product.price}",
//             style: const TextStyle(fontSize: 22),
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 // 🟢 ADD TO CART
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       cart.addToCart(widget.product);

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Added to Cart")),
//                       );
//                     },
//                     child: const Text("Add to Cart"),
//                   ),
//                 ),

//                 const SizedBox(width: 10),

//                 // 🔵 BUY NOW
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       openCheckout(widget.product.price.toInt());
//                     },
//                     child: const Text("Buy Now"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }









///////////

// import 'package:api/firebaseProvider/model/product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/cart_provider.dart';

// class DetailScreen extends StatelessWidget {
//   final Product product;

//   DetailScreen({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text(product.title)),
//       body: Column(
//         children: [
//           Expanded(
//             child: Image.network(product.image),
//           ),
//           Text(
//             "₹${product.price}",
//             style: TextStyle(fontSize: 20),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               cart.addToCart(product);
//             },
//             child: Text("Add to Cart"),
//           )
//         ],
//       ),
//     );
//   }
// }
