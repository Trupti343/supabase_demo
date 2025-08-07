import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_demo/app/modules/users/controllers/users_controller.dart';
// import 'users_controller.dart';

class UsersView extends GetView<UsersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final user = controller.users[index];
            return ListTile(
              title: Text(user['email']),
              onTap: () => controller.startChat(user['id']),
            );
          },
        );
      }),
    );
  }
}
