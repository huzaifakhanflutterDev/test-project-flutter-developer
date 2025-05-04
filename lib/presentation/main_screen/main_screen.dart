import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_flutter_developer/core/app_colors/app_colors.dart';
import 'package:test_task_flutter_developer/presentation/main_screen/favourites_screen/favourites_viewmodel/favourite_viewmodel.dart';
import 'package:test_task_flutter_developer/presentation/main_screen/product_screen/product_viewmodel/product_view_model.dart';

import '../../core/utils/widgets/custom_bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoritesController = Get.put(FavoritesController());
    final ProductController controller = Get.put(ProductController());
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.primaryBlack,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primaryWhite,
          surfaceTintColor: AppColors.primaryWhite,
          centerTitle: true,
          title: Obx(
            () {
              return Text(
                controller.titles[controller.selectedTabIndex.value],
                style: GoogleFonts.playfairDisplay(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
        body: Obx(
          () => controller.screenList[controller.selectedTabIndex.value],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          controller: controller,
        ),
      ),
    );
  }
}
