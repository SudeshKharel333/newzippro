import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NoticeDetailsLogic extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    // debugPrint("onInit");
  }
}
