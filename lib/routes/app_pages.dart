import 'package:get/get.dart';

import '/screen/auth/editprofile/editprofile_binding.dart';
import '/screen/auth/editprofile/editprofile_view.dart';
import '/screen/auth/login/login_binding.dart';
import '/screen/auth/login/login_view.dart';
import '/screen/auth/profile/profile_binding.dart';
import '/screen/auth/profile/profile_view.dart';
import '/screen/auth/register/register_binding.dart';
import '/screen/auth/register/register_view.dart';

import '/screen/search_screen/search_binding.dart';
import '/screen/search_screen/search_view.dart';
import '/screen/product/product_view.dart';
import '/screen/shop_home/shop_home_binding.dart';
import '/screen/shop_home/shop_home_view.dart';

import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    // Home Screen Route
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const ShopHomePage(),
      binding: ShopHomeBinding(),
    ),

    // Register Page Route
    GetPage(
      name: AppRoutes.registerPage,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),

    // Login Page Route
    GetPage(
      name: AppRoutes.loginPage,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),

    // Product Page Route
    GetPage(
      name: AppRoutes.productPage,
      page: () {
        final productId = int.tryParse(Get.parameters['productId'] ?? '') ?? 0;
        return ProductPage(productId: productId);
      },
    ),

    GetPage(
      name: AppRoutes.searchPage,
      page: () {
        final query = Get.parameters['query'] ?? "";
        return SearchScreen(query: query);
      },
      binding: Searchbinding(),
    ),

    // Profile Page Route
    GetPage(
      name: AppRoutes.profilePage,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),

    GetPage(
      name: AppRoutes.editProfilePage,
      page: () => const EditProfileView(),
      binding: EditprofileBinding(),
    ),
  ];
}
