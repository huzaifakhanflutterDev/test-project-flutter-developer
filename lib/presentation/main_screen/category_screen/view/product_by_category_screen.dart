import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_flutter_developer/core/app_colors/app_colors.dart';

import '../../../../core/utils/widgets/product_card.dart';
import '../../../../core/utils/widgets/search_bar.dart';
import '../../../main_screen/product_screen/product_view/product_details_view.dart';
import '../viewmodel/product_by_category_controller.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  final String category;

  const ProductsByCategoryScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(ProductsByCategoryController(category: category));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _formatCategoryName(category),
          style: GoogleFonts.playfairDisplay(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
        surfaceTintColor: AppColors.primaryWhite,
        backgroundColor: AppColors.primaryWhite,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryBlack,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Column(
          children: [
            CustomSearchBar(
              onChanged: (value) => controller.searchProducts(value),
              hintText: 'Search categories...',
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.w, bottom: 1.h),
              child: Obx(
                    () => Align(
                  alignment: Alignment.centerLeft,
                  child: controller.searchQuery.value.isNotEmpty
                      ? Text(
                    controller.filteredProducts.isEmpty
                        ? 'No products found'
                        : '${controller.filteredProducts.length} results found',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                  )
                      : const SizedBox.shrink(),
                ),
              ),
            ),

            Expanded(
              child: Obx(
                () {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (controller.hasError.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Error loading products',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            controller.errorMessage.value,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 2.h),
                          ElevatedButton(
                            onPressed: controller.fetchProducts,
                            child: Text(
                              'Try Again',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (controller.filteredProducts.isEmpty) {
                    return Center(
                      child: Text(
                        'No products found',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    itemCount: controller.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ProductDetailsView(
                              productData: product,
                            ),
                          );
                        },
                        child: ProductCard(
                          product: product,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCategoryName(String category) {
    return category
        .split(RegExp(r'[-_]'))
        .map((word) => word.capitalizeFirst)
        .join(' ');
  }
}
