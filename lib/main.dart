import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_flutter_developer/core/app_colors/app_colors.dart';
import 'package:test_task_flutter_developer/presentation/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_, __, ___) {
        return GetMaterialApp(
          title: 'Flutter Test App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.primaryWhite,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
/*lib/
    main.dart
    app.dart

    core/
        api/
            api_service.dart
        constants/
            api_endpoints.dart
        utils/
            navigation.dart
            theme.dart

    data/
        models/
            product_model.dart
            category_model.dart
        repositories/
            product_repository.dart
            category_repository.dart

    presentation/
        common/
            widgets/
                search_bar.dart
                product_card.dart
        features/
            splash/
                splash_screen.dart
            main/
                main_screen.dart
            products/
                viewmodels/
                    products_viewmodel.dart
                views/
                    products_screen.dart
                    product_details_screen.dart
            categories/
                viewmodels/
                    categories_viewmodel.dart
                views/
                    categories_screen.dart
                    products_by_category_screen.dart
            favorites/
                viewmodels/
                    favorites_viewmodel.dart
                views/
                    favorites_screen.dart
            user/
                views/
                    user_screen.dart

    state/
        favorites_state.dart*/
