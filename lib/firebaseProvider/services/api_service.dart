import 'dart:convert';
import 'package:api/firebaseProvider/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse("https://dummyjson.com/products"));

    final data = jsonDecode(response.body);

    return (data['products'] as List).map((e) => Product.fromJson(e)).toList();
  }
}
