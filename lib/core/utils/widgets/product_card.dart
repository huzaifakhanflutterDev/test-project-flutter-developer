import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_flutter_developer/core/app_colors/app_colors.dart';
import 'package:test_task_flutter_developer/core/extensions/opacity_extension.dart';

import '../../models/products_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: .75.h,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 25.h,
            width: 90.w,
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Center(
              child: product.thumbnail.isNotEmpty
                  ? Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[400],
                              size: 10.w,
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    )
                  : Icon(
                      Icons.image_not_supported,
                      color: Colors.grey[400],
                      size: 10.w,
                    ),
            ),
          ),
        ),

        // Product Details
        SizedBox(height: 1.h),

        // Title and Brand
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70.w,
              child: Text(
                product.title,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: AppColors.primaryBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '\$${product.price}',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: AppColors.primaryBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),

        Row(
          children: [
            Text(
              '${product.rating}',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: AppColors.primaryBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(width: 1.w),
            RatingBarIndicator(
              rating: product.rating,
              itemBuilder: (context, index) => Icon(
                Icons.star_rounded,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 17,
              direction: Axis.horizontal,
            ),
          ],
        ),
        Text(
          "By ${product.brand}",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: const Color(0xff0C0C0C).customOpacity(.5),
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(height: 0.2.h),
        Text(
          "In ${product.category.replaceFirst(product.category[0], product.category[0].toUpperCase())}",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: AppColors.primaryBlack,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
