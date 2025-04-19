import 'package:get/get.dart';

import 'shop_home_logic.dart';

class ShopHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShopHomeLogic());
  }
}
