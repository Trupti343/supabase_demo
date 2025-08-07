// import 'package:get/get.dart';

// class InAppPurchaseController extends GetxController {
  
//   final RxList<Map<String, dynamic>> products = [
//     {'id': 'remove_ads', 'title': 'Remove Ads', 'price': '₹99'},
//     {'id': '100_coins', 'title': '100 Coins', 'price': '₹49'},
//     {'id': 'pro_theme', 'title': 'Pro Theme', 'price': '₹79'},
//   ].obs;

  
//   final RxList<String> purchased = <String>[].obs;
 
//   void purchaseProduct(String productId) {
//     if (!purchased.contains(productId)) {
//       purchased.add(productId);
//       Get.snackbar("Purchased", "You purchased $productId");
//     } else {
//       Get.snackbar("Info", "You already own $productId");
//     }
//   }
// }

import 'dart:async';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseController extends GetxController {
  final InAppPurchase _iap = InAppPurchase.instance;
  final RxList<ProductDetails> products = <ProductDetails>[].obs;
  final RxList<PurchaseDetails> purchases = <PurchaseDetails>[].obs;

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  final Set<String> _kProductIds = {'remove_ads', '100_coins', 'pro_theme'};

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    final bool available = await _iap.isAvailable();
    if (!available) {
      Get.snackbar("Error", "Store not available");
      return;
    }

    _subscription = _iap.purchaseStream.listen(_onPurchaseUpdated, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      Get.snackbar("Purchase Error", error.toString());
    });

    final ProductDetailsResponse response =
        await _iap.queryProductDetails(_kProductIds);

    if (response.error != null) {
      Get.snackbar("Error", response.error!.message);
      return;
    }

    products.assignAll(response.productDetails);
  }

  void buy(ProductDetails product) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void _onPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (final purchase in purchaseDetailsList) {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        purchases.add(purchase);
        _iap.completePurchase(purchase);
        Get.snackbar("Purchased", "You purchased ${purchase.productID}");
      } else if (purchase.status == PurchaseStatus.error) {
        Get.snackbar("Error", purchase.error?.message ?? 'Purchase failed');
      }
    }
  }

  bool isPurchased(String productId) {
    return purchases.any((purchase) => purchase.productID == productId);
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}


