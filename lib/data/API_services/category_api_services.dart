import 'dart:convert';

import 'package:http/http.dart' as http;

class CategoryService {
  static Future<List<String>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products/categories'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          return data.map<String>((e) {
            if (e is Map && e.containsKey('name')) {
              return e['name'].toString();
            } else if (e is String) {
              return e;
            } else {
              return '';
            }
          }).toList();
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  static Future<List<dynamic>> fetchProductsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products/category/$category'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map && data.containsKey('products')) {
          return data['products'];
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
