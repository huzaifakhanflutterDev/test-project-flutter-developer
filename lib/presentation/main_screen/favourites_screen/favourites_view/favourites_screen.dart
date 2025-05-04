import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_flutter_developer/core/app_colors/app_colors.dart';
import 'package:test_task_flutter_developer/core/extensions/opacity_extension.dart';
import 'package:test_task_flutter_developer/core/models/products_model.dart';
import 'package:test_task_flutter_developer/core/utils/widgets/search_bar.dart';

import '../../product_screen/product_view/product_details_view.dart';
import '../favourites_viewmodel/favourite_viewmodel.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoritesController =
        Get.put(FavoritesController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              hintText: 'Search favourites...',
              onChanged: (query) {
                favoritesController.searchQuery.value = query;
              },
            ).paddingSymmetric(
              vertical: 0,
            ),
            Obx(
              () {
                final filteredProducts = favoritesController.favoriteProducts
                    .where((product) => product.title.toLowerCase().contains(
                        favoritesController.searchQuery.value.toLowerCase()))
                    .toList();

                return favoritesController.searchQuery.value.isNotEmpty
                    ? Text(
                        '${filteredProducts.length} results found',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                        ),
                      )
                    : SizedBox.shrink();
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(
                () {
                  if (favoritesController.favoriteProducts.isEmpty) {
                    return Center(
                      child: Text(
                        'No favorites added yet',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }

                  final filteredProducts = favoritesController.favoriteProducts
                      .where((product) => product.title.toLowerCase().contains(
                          favoritesController.searchQuery.value.toLowerCase()))
                      .toList();

                  return ListView.separated(
                    itemCount: filteredProducts.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemBuilder: (context, index) {
                      return _buildProductItem(
                          filteredProducts[index], favoritesController);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(
      Product product, FavoritesController favoritesController) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsView(productData: product));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.customOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 20.w,
              height: 10.h,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.network(
                  product.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 0.25.h),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 0.25.h),
                  Row(
                    children: [
                      Text(
                        product.rating.toString(),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 1.w),
                      RatingBarIndicator(
                        rating: product.rating,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 17,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => favoritesController.toggleFavorite(product),
              child: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
