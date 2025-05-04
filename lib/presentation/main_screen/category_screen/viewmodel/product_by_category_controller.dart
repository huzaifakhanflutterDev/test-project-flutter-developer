import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task_flutter_developer/core/models/products_model.dart';

import '../../../../data/API_services/category_api_services.dart';

class ProductsByCategoryController extends GetxController {
  final String category;
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var searchQuery = ''.obs;


  ProductsByCategoryController({required this.category});

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      hasError(false);
      errorMessage('');

      final data = await CategoryService.fetchProductsByCategory(category);

      final productList = data.map((item) => Product.fromJson(item)).toList();

      products.assignAll(productList.cast<Product>());
      filteredProducts.assignAll(products);
    } catch (e) {
      debugPrint("Error fetching products: $e");
      hasError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void searchProducts(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filteredProducts.assignAll(products);
      return;
    }

    final results = products.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase()) ||
          product.description.toLowerCase().contains(query.toLowerCase()) ||
          product.brand.toLowerCase().contains(query.toLowerCase());
    }).toList();

    filteredProducts.assignAll(results);
  }

}
