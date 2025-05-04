import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task_flutter_developer/presentation/main_screen/category_screen/view/category_screen.dart';
import 'package:test_task_flutter_developer/presentation/main_screen/category_screen/viewmodel/category_viewmodel.dart';
import 'package:test_task_flutter_developer/presentation/main_screen/favourites_screen/favourites_view/favourites_screen.dart';
import 'package:test_task_flutter_developer/presentation/main_screen/product_screen/product_view/product_view.dart';
import 'package:test_task_flutter_developer/presentation/main_screen/profile_screen/profile_Screen.dart';

import '../../../../core/models/products_model.dart';
import '../../../../data/API_services/api_services.dart';
import '../../favourites_screen/favourites_viewmodel/favourite_viewmodel.dart';

class ProductController extends GetxController {
  final ApiService _apiService = ApiService();

  final selectedTabIndex = 0.obs;

  final searchQuery = ''.obs;
  final isSearching = false.obs;

  final categories = <String>[].obs;
  final filteredCategories = <String>[].obs;

  final productsList = <Product>[].obs;
  final filteredProducts = <Product>[].obs;
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  List<String> titles = [
    "Products",
    "Categories",
    "Favourites",
    "Profile",
  ];

  List screenList = [
    ProductScreen(),
    CategoryScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchCategories();
  }

  void clearSearchQuery() {
    if (searchQuery.isNotEmpty) {
      searchQuery.value = '';
      filteredProducts.assignAll(productsList);
    }
  }

  void changeTab(int index) {
    if (selectedTabIndex.value == 0 && index != 0) {
      clearSearchQuery();
      log("search bar data is cleared!");
    }
    if (selectedTabIndex.value ==1 && index != 1) {
      Get.find<CategoryController>().searchQuery.value = '';
      log("Category search bar data is cleared!");
    }
    if (selectedTabIndex.value ==2 && index != 2) {
      Get.find<FavoritesController>().searchQuery.value = '';
      log("Favorite search bar data is cleared!");
    }

    selectedTabIndex.value = index;
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final products = await _apiService.fetchProducts();
      productsList.value = products;
      filteredProducts.value = products;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = e.toString();
      debugPrint('Error fetching products: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      final result = await _apiService.getCategories();
      categories.assignAll(result);
      filteredCategories.assignAll(result);
    } catch (e) {
      errorMessage('Failed to fetch categories: $e');
    } finally {
      isLoading(false);
    }
  }

  void searchProducts(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filteredProducts.value = productsList;
      return;
    }

    final results = productsList.where((product) {
      final titleMatch =
          product.title.toLowerCase().contains(query.toLowerCase());
      final descriptionMatch =
          product.description.toLowerCase().contains(query.toLowerCase());
      final brandMatch =
          product.brand.toLowerCase().contains(query.toLowerCase());
      final categoryMatch =
          product.category.toLowerCase().contains(query.toLowerCase());

      return titleMatch || descriptionMatch || brandMatch || categoryMatch;
    }).toList();

    filteredProducts.value = results;
  }

  void searchCategories(String query) {
    searchQuery(query);
    if (query.isEmpty) {
      filteredCategories.assignAll(categories);
    } else {
      filteredCategories.assignAll(categories
          .where((c) => c.toLowerCase().contains(query.toLowerCase())));
    }
  }

  Future<void> refreshProducts() async {
    await fetchProducts();
    searchQuery.value = '';
  }
}
