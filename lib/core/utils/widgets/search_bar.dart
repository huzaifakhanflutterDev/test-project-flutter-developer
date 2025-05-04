import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_flutter_developer/core/app_colors/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;
  final TextEditingController? controller;

  const CustomSearchBar({
    super.key,
    required this.onChanged,
    this.hintText = 'Search',
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: BorderSide(
            color: AppColors.primaryBlack,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: BorderSide(
            color: AppColors.primaryBlack,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: BorderSide(
            color: AppColors.primaryBlack,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 1.h),
        prefixIcon: SizedBox(
          height: 5.h,
          width: 5.w,
          child: Center(
            child: SvgPicture.asset(
              'assets/icons_svg/search.svg',
              color: AppColors.primaryBlack,
              height: 16,
              width: 16,
            ),
          ),
        ),
        hintStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: 16.sp,
          ),
        ),
      ),
      onChanged: onChanged,
    ).paddingSymmetric(vertical: 1.h);
  }
}
