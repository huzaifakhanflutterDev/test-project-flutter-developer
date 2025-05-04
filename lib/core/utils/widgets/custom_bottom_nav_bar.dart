import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_flutter_developer/core/app_colors/app_colors.dart';
import 'package:test_task_flutter_developer/presentation/main_screen/product_screen/product_viewmodel/product_view_model.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final ProductController controller;

  const CustomBottomNavigationBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 9.h,
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: controller.selectedTabIndex.value,
            onTap: controller.changeTab,
            backgroundColor: AppColors.primaryBlack,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Color(0xffF2F2F2),
            selectedFontSize: 15.sp,
            unselectedFontSize: 15.sp,
            selectedLabelStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons_svg/Product.svg"),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons_svg/category.svg"),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons_svg/fav.svg"),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons_svg/person.svg"),
                label: 'Mit Konto',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
