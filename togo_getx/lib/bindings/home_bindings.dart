import 'package:get/get.dart';

import '../controllers/controllers.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductListController());
  }
}