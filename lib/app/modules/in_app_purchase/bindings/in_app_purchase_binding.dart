import 'package:get/get.dart';

import '../controllers/in_app_purchase_controller.dart';

class InAppPurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InAppPurchaseController>(
      () => InAppPurchaseController(),
    );
  }
}
