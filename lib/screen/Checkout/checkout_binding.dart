import 'package:get/get.dart';
import '/screen/checkout/checkout_logic.dart';
//import '/screen/cart/cart_logic.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckoutLogic());
  }
}
