import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/deep_link_controller.dart';

class DeepLinkView extends GetView<DeepLinkController> {
  const DeepLinkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deep Link Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              final link = controller.latestLink.value;
              if (link.isEmpty) {
                return const Text(
                  'No deep link received yet.',
                  textAlign: TextAlign.center,
                );
              }

              return InkWell(
                onTap: () {
                  final uri = Uri.parse(link);
                  controller.handleDeepLinkFromTap(uri);
                },
                child: Text(
                  'Received deep link:\n$link',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: controller.setDummyLink,
              child: const Text("Simulate Dummy Deep Link"),
            ),
          ],
        ),
      ),
    );
  }
}
