import 'package:get/get.dart';

class MainController extends GetxController {
  final selectedTabIndex = 0.obs;
  final searchQuery = ''.obs;
  final searchResults = 234.obs;

  // final productsList = <Product>[
  //   Product(
  //     id: 1,
  //     name: 'iPhone 14',
  //     brand: 'Apple',
  //     price: 60,
  //     rating: 4.9,
  //     category: 'smartphones',
  //     imagePath: '',
  //   ),
  //   Product(
  //     id: 2,
  //     name: 'Samsung Galaxy Book',
  //     brand: 'Samsung',
  //     price: 60,
  //     rating: 4.9,
  //     category: 'laptops',
  //     imagePath: '',
  //   ),
  // ].obs;

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
