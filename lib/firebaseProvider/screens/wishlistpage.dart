import 'package:api/firebaseProvider/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body: wishlist.wishlist.isEmpty
          ? const Center(child: Text("Wishlist Empty"))
          : ListView.builder(
              itemCount: wishlist.wishlist.length,
              itemBuilder: (context, index) {
                final product = wishlist.wishlist[index];

                return ListTile(
                  leading: Image.network(product.image, width: 50),
                  title: Text(product.title),
                  subtitle: Text("₹${product.price}"),
                );
              },
            ),
    );
  }
}
