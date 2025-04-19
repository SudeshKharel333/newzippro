import 'package:get/get.dart';

import 'editprofile_logic.dart';

class EditprofileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditprofileLogic());
  }
}
