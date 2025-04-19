import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '/constants/api.dart';
import 'package:dio/dio.dart' as responsee;
import '/providers/shop_provider.dart';
import '/providers/slider_provider.dart';
import '../../core/widgets/costume_dialog.dart';
import '../../models/shop_response.dart';
import '../../models/slider_response.dart';
import '../../routes/app_routes.dart';

class ShopHomeLogic extends GetxController {
  // //Carousel slider controller to manage carousel actions
  // CarouselSliderController carouselController = CarouselSliderController();

  // // List to hold slider images
  // List<String> imgList = [];
  // // Initializing providers for store and slider data
  // final _provider = StoreProvider();
  // final _sliderProvider = SliderProvider();

  // // List to hold category and product data
  // List<Categories> categories = [];
  // List<Products> latestProducts = [];

  // // Storage for local data persistence
  // final storage = GetStorage();

  // // To manage the current state of the carousel
  // int current = 0;

  // // Method called when the controller is initialized
  // @override
  // void onInit() async {
  //   await getCategories(); // Fetch categories on init
  //   await getLatestProducts(); // Fetch latest products on init
  //   await getSliderImages(); // Fetch slider images on init
  //   super.onInit();
  // }

  // // Function to fetch categories from the server
  // Future<void> getCategories() async {
  //   // Calling API using the provider
  //   responsee.Response response = await _provider.getCategories();

  //   // Checking if response is successful
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     // Parsing response data into a list of categories
  //     categories =
  //         (response.data as List).map((x) => Categories.fromJson(x)).toList();
  //     debugPrint(categories); // Debugging
  //   } else {
  //     // If unauthorized, navigate to login screen
  //     if (response.statusCode == 401) {
  //       // Get.offAllNamed(AppRoutes.loginScreen);
  //     }
  //     // Showing error dialog in case of server error
  //     showDialog(
  //         context: Get.context!,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) {
  //           return CostumeDialog(
  //             title: "error",
  //             titleColor: Colors.red,
  //             message: "server invalid",
  //             buttom1Lavel: "OK",
  //             onButton1Clicked: () {},
  //             button2Enabled: false,
  //           );
  //         });
  //   }
  // }

  // // Function to fetch subcategories based on category ID
  // Future<void> getSubCategory(int? id) async {
  //   responsee.Response response = await _provider.getSubCategories(id ?? 1);

  //   // If response is successful, log the categories
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     debugPrint(categories); // Debugging
  //   } else {
  //     // Displaying an error dialog if the server fails
  //     showDialog(
  //         context: Get.context!,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) {
  //           return CostumeDialog(
  //             title: "error",
  //             titleColor: Colors.red,
  //             message: "server invalid",
  //             buttom1Lavel: "OK",
  //             onButton1Clicked: () {},
  //             button2Enabled: false,
  //           );
  //         });
  //   }
  // }

  // // Function to fetch the latest products
  // Future<void> getLatestProducts() async {
  //   responsee.Response response = await _provider.getLatestProducts();

  //   // If response is successful, map and parse product data
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     latestProducts =
  //         (response.data as List).map((x) => Products.fromJson(x)).toList();
  //   } else {
  //     // Showing error dialog if server fails
  //     showDialog(
  //         context: Get.context!,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) {
  //           return CostumeDialog(
  //             title: "error",
  //             titleColor: Colors.red,
  //             message: "server invalid",
  //             buttom1Lavel: "OK",
  //             onButton1Clicked: () {},
  //             button2Enabled: false,
  //           );
  //         });
  //   }
  // }

  // // Function to calculate the discount percentage for a product
  // calculateDiscount(int index) {
  //   int discount = latestProducts[index].productPriceBeforeDiscount! -
  //       latestProducts[index].productPrice!;
  //   double percentage = (discount * 100) / latestProducts[index].productPrice!;
  //   return percentage.toStringAsFixed(1); // Return discount as percentage
  // }

  // // Function to fetch slider images for the homepage
  // Future<void> getSliderImages() async {
  //   responsee.Response response = await _sliderProvider.getSlider();

  //   // If response is successful, extract slider images
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     List<SliderResponse> sliders = (response.data as List)
  //         .map((x) => SliderResponse.fromJson(x))
  //         .toList();

  //     // Add image URLs to imgList
  //     for (var item in sliders) {
  //       imgList
  //           .add("${apiBaseImageUrl}assets/images/sliders/${item.sliderImage}");
  //     }
  //     debugPrint(imgList); // Debugging
  //   } else {
  //     // Show error dialog in case of a failed server response
  //     showDialog(
  //         context: Get.context!,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) {
  //           return CostumeDialog(
  //             title: "error",
  //             titleColor: Colors.red,
  //             message: "server invalid",
  //             buttom1Lavel: "OK",
  //             onButton1Clicked: () {},
  //             button2Enabled: false,
  //           );
  //         });
  //   }
  // }

  // // Method to navigate to sub-category screen and pass selected category details
  // gotoSubCat(String catName, int catId) {
  //   storage.write("cat_name", catName); // Save category name in storage
  //   storage.write("cat_id", catId); // Save category ID in storage
  //   // Get.toNamed(AppRoutes.subCatScreen); // Navigate to sub-category screen
  // }
}
