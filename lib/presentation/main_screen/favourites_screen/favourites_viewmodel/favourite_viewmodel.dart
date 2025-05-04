import 'package:get/get.dart';
import 'package:test_task_flutter_developer/core/models/products_model.dart';

class FavoritesController extends GetxController {
  final RxList<Product> favoriteProducts = <Product>[].obs;
  final searchQuery = ''.obs;

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      favoriteProducts.removeWhere((item) => item.id == product.id);
    } else {
      favoriteProducts.add(product);
    }
  }

  bool isFavorite(Product product) {
    return favoriteProducts.any((item) => item.id == product.id);
  }

  int get favoriteCount => favoriteProducts.length;
}
