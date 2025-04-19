import 'package:get/get.dart';

import 'product_logic.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductLogic());
  }
}
