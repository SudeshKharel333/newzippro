import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/app_managers/assets_managers.dart';
import '/core/enums/validation_type.dart';
import '/routes/app_routes.dart';
import '/screen/auth/auth_helper.dart';
import '/screen/auth/register/register_view.dart';

import '../../../widgets/buttons.dart';
import '../../../widgets/input_fields.dart';
import 'login_logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    debugPrint('Login page initState()');

    // Checking if logged in to skip login screen
    AuthHelper.isLoggedIn().then((isLoggedIn) {
      debugPrint('isLoggedIn = $isLoggedIn');
      if (isLoggedIn) {
        Get.offAllNamed(AppRoutes.homeScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginLogic>(builder: (logic) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 167, 218, 242),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      AssetManager.Zippro,
                      width: 170,
                      height: 170,
                    ),
                  ),
                  const Gap(12),
                  const Text(
                    "Welcome to \n ZipPro",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const Text(
                    "version 1.0.0",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 190, 202, 212)),
                  ),
                  const Gap(44),
                  const Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 100.0,
                  ),
                  const Text(
                    "Enter your credentials to login",
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const Gap(16),
                  CostumeFormField(
                    validationType: ValidationType.email,
                    controller: logic.emailController,
                    hintText: "Enter your Email",
                    labelText: "Email",
                  ),
                  const Gap(16),
                  CostumeFormField(
                    validationType: ValidationType.password,
                    controller: logic.passwordController,
                    hintText: "Enter your Password",
                    labelText: "Password",
                  ),
                  const Gap(6),
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                          onTap: () {
                            debugPrint("forget password clicked");
                          },
                          child: const Text(
                            "Forget password?",
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  ),
                  const Gap(40),
                  CostumeButtons.common(
                    labelText: 'Login',
                    onPressed: logic.validateFields()
                        ? () async {
                            // Ensure that login logic runs only if the fields are validated
                            await logic.login();
                          }
                        : null, // Disable button if validation fails
                    isEnabled: logic.validateFields(),
                  ),
                  const Gap(20),
                  CostumeButtons.blueBorder(
                    labelText: 'Signup',
                    onPressed: () {
                      Get.to(() =>
                          const RegisterPage()); // Navigate to RegisterPage
                    },
                    isEnabled: true, // or based on your logic
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
