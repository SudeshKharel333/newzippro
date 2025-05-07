import 'package:dio/dio.dart' as dio_form_data;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/helper/input_validator.dart';
import 'package:image_picker/image_picker.dart';

class RegisterLogic extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final dio_form_data.Dio _dio = dio_form_data.Dio();
  XFile? _imageFile;

  // Set the image file
  void setImageFile(XFile image) {
    _imageFile = image;
  }

  Future<void> registerUser() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        phoneController.text.isEmpty ||
        fullNameController.text.isEmpty ||
        _imageFile == null) {
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
      dio_form_data.FormData formData = dio_form_data.FormData.fromMap({
        'email': emailController.text,
        'password': passwordController.text,
        'fullName': fullNameController.text,
        'phone': phoneController.text,
        'imageFile': await dio_form_data.MultipartFile.fromFile(
          _imageFile!.path,
          filename: 'upload.jpg',
        ),
      });

      final response = await _dio.post(
        'http://192.168.1.70:3500/register', // replace <YOUR_LOCAL_IP> with your IP address
        data: formData,
        //debugPrint('inside api');
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Registration successful!');
      } else {
        Get.snackbar('Error', 'Registration failed. ${response.data}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      Get.snackbar('Error', 'An error occurred during registration.');
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
