import 'package:get/get.dart';

import '../controllers/deep_link_controller.dart';

class DeepLinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeepLinkController>(
      () => DeepLinkController(),
    );
  }
}
