import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_flutter_developer/core/app_colors/app_colors.dart';
import 'package:test_task_flutter_developer/core/models/products_model.dart';

import '../../favourites_screen/favourites_viewmodel/favourite_viewmodel.dart';

class ProductDetailsView extends StatelessWidget {
  final Product productData;
  final FavoritesController favoritesController =
      Get.put(FavoritesController());

  ProductDetailsView({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.primaryWhite,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProductInfo(favoritesController),
                        const SizedBox(height: 20),
                        _buildProductGallery(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Product Details",
                style: GoogleFonts.playfairDisplay(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
    );
  }

  Widget _buildProductInfo(FavoritesController favoritesController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeroSection(),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              'Product Details:',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Spacer(),
            Obx(() => GestureDetector(
                  onTap: () => favoritesController.toggleFavorite(productData),
                  child: Icon(
                    favoritesController.isFavorite(productData)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 32,
                    color: favoritesController.isFavorite(productData)
                        ? Colors.red
                        : Colors.black,
                  ),
                )),
          ],
        ),
        const SizedBox(height: 15),
        _buildDetailRow('Name:', productData.title),
        _buildDetailRow('Price:', '\$${productData.price.toStringAsFixed(2)}'),
        _buildDetailRow('Category:', productData.category),
        _buildDetailRow('Brand:', productData.brand),
        _buildRatingRow('Rating:', productData.rating),
        _buildDetailRow('Stock:', productData.stock.toString()),
        const SizedBox(height: 15),
        Text(
          'Description:',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          productData.description,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 15.sp,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: Image.network(
        productData.thumbnail,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow(String label, double rating) {
    final fullStars = rating.floor();
    final hasHalfStar = (rating - fullStars) >= 0.5;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            rating.toString(),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 5),
          RatingBarIndicator(
            rating: rating,
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
    );
  }

  Widget _buildProductGallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Gallery:',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 15),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _buildGalleryItem(productData.thumbnail),
            _buildGalleryItem(productData.images.isNotEmpty
                ? productData.images[0]
                : productData.thumbnail),
          ],
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _buildGalleryItem(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
