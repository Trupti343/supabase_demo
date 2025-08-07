import 'package:get/get.dart';

import '../controllers/merge_video_controller.dart';

class MergeVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MergeVideoController>(
      () => MergeVideoController(),
    );
  }
}
