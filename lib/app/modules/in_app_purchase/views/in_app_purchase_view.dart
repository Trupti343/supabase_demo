// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/in_app_purchase_controller.dart';

// class InAppPurchaseView extends GetView<InAppPurchaseController> {
//   const InAppPurchaseView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final InAppPurchaseController controller = Get.put(InAppPurchaseController());

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('In-App Purchase Demo'),
//         centerTitle: true,
//       ),
//       body: Obx(() => ListView.builder(
//             itemCount: controller.products.length,
//             itemBuilder: (context, index) {
//               final product = controller.products[index];
//               final isPurchased = controller.purchased.contains(product['id']);

//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 child: ListTile(
//                   title: Text(product['title']),
//                   subtitle: Text(product['price']),
//                   trailing: isPurchased
//                       ? const Icon(Icons.check_circle, color: Colors.green)
//                       : ElevatedButton(
//                           onPressed: () => controller.purchaseProduct(product['id']),
//                           child: const Text("Buy"),
//                         ),
//                 ),
//               );
//             },
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/in_app_purchase_controller.dart';

class InAppPurchaseView extends StatelessWidget {
  final controller = Get.put(InAppPurchaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('In-App Purchase'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            final isPurchased = controller.isPurchased(product.id);

            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(product.title),
                subtitle: Text(product.price),
                trailing: isPurchased
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : ElevatedButton(
                        onPressed: () => controller.buy(product),
                        child: const Text("Buy"),
                      ),
              ),
            );
          },
        );
      }),
    );
  }
}



