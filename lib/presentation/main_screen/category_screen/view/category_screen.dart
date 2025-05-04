import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_flutter_developer/presentation/main_screen/category_screen/view/product_by_category_screen.dart';

import '../../../../core/utils/widgets/search_bar.dart';
import '../viewmodel/category_viewmodel.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      body: Padding(
         padding:  EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              hintText: 'Search categories...',
              onChanged: (query) {
                controller.searchQuery.value = query;
              },
            ),
            Obx(
              () => controller.searchQuery.value.isNotEmpty
                  ? Text(
                      '${controller.filteredCategories.length} results found',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.sp,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: Obx(
                () {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final categories = controller.filteredCategories;

                  if (categories.isEmpty) {
                    return Center(
                      child: Text(
                        'No categories found',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.h),
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2.h,
                      crossAxisSpacing: 4.w,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      log(category.capitalizeFirst.toString());
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                              () => ProductsByCategoryScreen(category: category));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://picsum.photos/200/200/?random=$index"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              _formatCategoryName(category),
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ).paddingSymmetric(vertical: 3.h, horizontal: 3.w),
                          ),
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
