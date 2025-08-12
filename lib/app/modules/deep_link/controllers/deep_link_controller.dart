import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DeepLinkController extends GetxController {
  RxString latestLink = ''.obs;
  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSub;

  @override
  void onInit() {
    super.onInit();
    _appLinks = AppLinks();
    _initDeepLinkListener();
  }

  Future<void> _initDeepLinkListener() async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleDeepLink(initialUri);
      }
    } catch (err) {
      latestLink.value = 'Failed to get initial link: $err';
    }

    _linkSub = _appLinks.uriLinkStream.listen(
      (uri) => _handleDeepLink(uri),
      onError: (err) {
        latestLink.value = 'Failed to receive link: $err';
      },
    );
  }

  void _handleDeepLink(Uri uri) {
    latestLink.value = uri.toString();

    if (uri.pathSegments.isNotEmpty) {
      final firstSegment = uri.pathSegments.first;

      if (firstSegment == 'product' && uri.pathSegments.length > 1) {
        final productId = uri.pathSegments[1];
        Get.toNamed('/product/$productId');
      }
    }
  }

  void handleDeepLinkFromTap(Uri uri) {
    _handleDeepLink(uri);
  }

  void setDummyLink() {
    final uri = Uri.parse("myapp://product/123?ref=abc&source=test");
    _handleDeepLink(uri);
  }

  @override
  void onClose() {
    _linkSub?.cancel();
    super.onClose();
  }
}
