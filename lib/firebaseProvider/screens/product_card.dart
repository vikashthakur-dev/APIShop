import 'package:api/firebaseProvider/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();

    return Card(
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(product.image, height: 150),
              Positioned(
                right: 5,
                top: 5,
                child: IconButton(
                  icon: Icon(
                    wishlist.isExist(product)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    wishlist.toggleWishlist(product);
                  },
                ),
              )
            ],
          ),
          Text(product.title, maxLines: 2),
          Text("₹${product.price}")
        ],
      ),
    );
  }
}
