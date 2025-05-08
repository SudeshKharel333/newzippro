import 'package:dio/dio.dart' as dio_form_data;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newzippro/constants/config.dart';
import '/core/helper/input_validator.dart';
import 'package:image_picker/image_picker.dart';

class EditprofileLogic extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final dio_form_data.Dio _dio = dio_form_data.Dio();
  // XFile? _imageFile;

  // Set the image file
  // void setImageFile(XFile image) {
  //   _imageFile = image;
  // }

  Future<void> updateUser() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        phoneController.text.isEmpty ||
        fullNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields.');
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match.');
      return;
    }

    if (!validateFields()) {
      Get.snackbar('Error', 'Invalid email or password format.');
      return;
    }

    try {
      final box = GetStorage();
      int user_id = box.read('userId');

      // if (user_id == null) {
      //   Get.snackbar('Error', 'User ID not found.');
      //   return;
      // }

      debugPrint("The user ID is $user_id");

      final formData = dio_form_data.FormData.fromMap({
        "user_id": user_id,
        "email": emailController.text,
        "password": passwordController.text,
        "fullName": fullNameController.text,
        "phone": phoneController.text,
      });

      final response = await _dio.post(
        '${AppConfig.baseUrl}/api/updateProfile',
        data: formData,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Profile updated successfully!');
      } else {
        Get.snackbar('Error', 'Update failed: ${response.statusMessage}');
      }
    } catch (e) {
      debugPrint('Error: $e');

      String errorMessage = 'An error occurred while updating the profile.';

      if (e is dio_form_data.DioException) {
        if (e.response != null) {
          debugPrint('Response data: ${e.response?.data}');
          debugPrint('Status code: ${e.response?.statusCode}');
          errorMessage = e.response?.data['error'] ?? errorMessage;
        } else {
          debugPrint('DioException message: ${e.message}');
          errorMessage =
              'No response from server. Check your internet connection.';
        }
      }

      Get.snackbar('Error', errorMessage);
    }
  }

  bool validateFields() {
    bool isEmailValid =
        InputValidators.emailValidator(emailController.text) == null;
    bool isPasswordValid =
        InputValidators.passwordValidator(passwordController.text) == null;

    return isEmailValid && isPasswordValid;
  }
}
