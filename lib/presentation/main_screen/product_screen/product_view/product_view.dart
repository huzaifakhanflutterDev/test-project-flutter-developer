import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_flutter_developer/presentation/main_screen/product_screen/product_view/product_details_view.dart';

import '../../../../core/utils/widgets/product_card.dart';
import '../../../../core/utils/widgets/search_bar.dart';
import '../product_viewmodel/product_view_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());
    return Scaffold(
      body: Padding(
         padding:  EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            CustomSearchBar(
              onChanged: (value) => controller.searchProducts(value),
              hintText: 'Search products...',
            ),
            Obx(
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
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            controller.errorMessage.value,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 2.h),
                          ElevatedButton(
                            onPressed: controller.fetchProducts,
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (controller.filteredProducts.isEmpty) {
                    return Center(
                      child: Text(
                        'No products found',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
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
}
