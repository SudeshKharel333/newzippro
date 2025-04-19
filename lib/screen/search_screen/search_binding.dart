import 'package:get/get.dart';
import 'search_logic.dart';

class Searchbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchLogic());
  }
}
