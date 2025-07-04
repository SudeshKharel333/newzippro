import 'package:dio/dio.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newzippro/constants/config.dart';
//import '/constants/api.dart';
import '/core/widgets/loading_dialog.dart';
import '/models/login_response.dart';
import '/screen/auth/auth_helper.dart';
import '/routes/app_routes.dart';

import '../../../core/helper/input_validator.dart';
import '../../../core/widgets/costume_dialog.dart';
//import '../../../providers/auth_provider.dart';

class LoginLogic extends GetxController {
  TextEditingController passwordController =
      TextEditingController(text: "Vandina@122");
  TextEditingController emailController =
      TextEditingController(text: "sudeshkharel15@gmail.com");

  //final _provider = AuthProvider();
  LoginResponse loginResponse = LoginResponse();

  final storage = GetStorage();
  Dio dio = Dio(BaseOptions(
      // baseUrl: 'http://localhost',
      //connectTimeout: const Duration(seconds: 10),
      //receiveTimeout: const Duration(seconds: 10),
      ));

  validateFields() {
    return InputValidators.emailValidator(emailController.text) == null &&
        InputValidators.simpleValidation(passwordController.text) == null;
  }

  login() async {
    if (Get.context != null) {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Loading("logging in..", false);
        },
      );
    }
    String email = emailController.text;
    String password = passwordController.text;

    try {
      debugPrint("inside api call2" + email + "-" + password);

      var response = await dio.post(
        '${AppConfig.baseUrl}/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          extra: {'port': 3500},
        ),
      );

      Get.back(); // Dismiss loading dialog
      if (response.statusCode == 200 && response.data['success'] == true) {
        // Successfully logged in
        debugPrint('Login successful: ${response.data}');
        AuthHelper.setLoginStatus(true);

// Extract user ID from response data (assuming response contains an ID field)
        final userId = response.data['userId'];
        debugPrint('Loginlogic initial  user_id: $userId');

        // Store user ID in GetStorage for later use
        final user = storage.write('userId', userId);
        print(user);
        debugPrint('Loginlogic userId: $userId');

        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        debugPrint('Login : ${response.data}');

        // Login failed even if status is 200

        Get.back(); // Dismiss loading
        showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CostumeDialog(
              title: "Error",
              titleColor: Colors.red,
              message: response.data['message'] ?? "Login failed",
              buttom1Lavel: "OK",
              onButton1Clicked: () async {
                Get.back();
              },
              button2Enabled: false,
            );
          },
        );
      }
    } catch (e) {
      String errorMessage = "";
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          errorMessage = "Invalid login credentials!";
        }
      }
      Get.back(); // Dismiss loading dialog
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CostumeDialog(
            title: "Error",
            titleColor: Colors.red,
            message: errorMessage,
            buttom1Lavel: "OK",
            onButton1Clicked: () async {
              // await login(); // Retry login
              Get.back();
            },
            button2Enabled: false,
          );
        },
      );
    }
  }
}
