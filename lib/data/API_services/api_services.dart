import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_task_flutter_developer/core/models/products_model.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';
  static const String productsEndpoint = '/products';

  Future<List<Product>> fetchProducts({int limit = 100}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$productsEndpoint?limit=$limit'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> productsJson = jsonData['products'];

        return productsJson
            .map((productJson) => Product.fromJson(productJson))
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$productsEndpoint/search?q=$query'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> productsJson = jsonData['products'];

        return productsJson
            .map((productJson) => Product.fromJson(productJson))
            .toList();
      } else {
        throw Exception('Failed to search products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products/categories'),
      );
      if (response.statusCode == 200) {
        final List categories = json.decode(response.body);
        return categories.cast<String>();
      }
      throw Exception('Failed to load categories: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }
}
