import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/API_services/category_api_services.dart';

class CategoryController extends GetxController {
  var categories = <String>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      hasError(false);
      errorMessage('');

      final data = await CategoryService.fetchCategories();
      categories.assignAll(data);
    } catch (e) {
      debugPrint("Error fetching categories: $e");
      hasError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  List<String> get filteredCategories {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      return categories;
    }
    return categories.where((c) => c.toLowerCase().contains(query)).toList();
  }
}
