import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gap/gap.dart';
import '/core/enums/validation_type.dart';
import '/screen/auth/editprofile/editprofile_logic.dart';
import '/widgets/buttons.dart';
import '/widgets/input_fields.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  bool _passwordsMatch = true;
  // File? _imageFile; // Declare the image file variable
  // final ImagePicker _picker = ImagePicker(); // Initialize the ImagePicker
  // final EditprofileLogic logic = Get.put(EditprofileLogic());

  // Future<void> _pickImage() async {
  //   // Request storage permission
  //   var status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     await Permission.storage.request();
  //   }

  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageFile = File(pickedFile.path);
  //       logic.setImageFile(pickedFile); // Update logic with selected image
  //     });
  //   } else {
  //     // Handle case when no image is picked
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('No image selected.')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditprofileLogic>(
      builder: (logic) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 167, 218, 242),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person_outline_rounded,
                      size: 50.0,
                      color: Colors.red,
                    ),
                    const Text(
                      "Enter your credentials to update",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const Gap(16),
                    CostumeFormField(
                      validationType: ValidationType.name,
                      hintText: "Enter Full Name",
                      controller: logic.fullNameController,
                      onChanged: () {
                        setState(() {});
                      },
                      labelText: "Name",
                    ),
                    const Gap(16),
                    CostumeFormField(
                      validationType: ValidationType.phone,
                      hintText: "Enter Phone Number",
                      controller: logic.phoneController,
                      onChanged: () {
                        setState(() {});
                      },
                      labelText: "Phone Number",
                    ),
                    const Gap(16),
                    CostumeFormField(
                      validationType: ValidationType.email,
                      controller: logic.emailController,
                      hintText: "Enter Email",
                      onChanged: () {
                        setState(() {});
                      },
                      labelText: "Email",
                    ),
                    const Gap(16),
                    Column(
                      children: [
                        CostumeFormField(
                          validationType: ValidationType.password,
                          controller: logic.passwordController,
                          hintText: "Enter Password",
                          labelText: "Password",
                          onChanged: () {
                            setState(() {});
                          },
                        ),
                        const Gap(16),
                        CostumeFormField(
                          validationType: ValidationType.password,
                          controller: logic.confirmPasswordController,
                          hintText: "Confirm Password",
                          labelText: "Confirm Password",
                          onChanged: () {
                            setState(() {
                              _passwordsMatch =
                                  logic.confirmPasswordController.text ==
                                      logic.passwordController.text;
                            });
                          },
                        ),
                      ],
                    ),
                    const Gap(20),
                    // _imageFile != null
                    //     ? Image.file(_imageFile!)
                    //     : Text('No image selected.'),
                    // SizedBox(height: 20),
                    // ElevatedButton(
                    //   onPressed: _pickImage,
                    //   child: Text('Pick Image'),
                    // ),
                    const Gap(20),
                    CostumeButtons.blueBorder(
                      labelText: 'Update',
                      onPressed: () {
                        logic.updateUser();
                      },
                      isEnabled: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
