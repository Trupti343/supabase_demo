import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_demo/app/modules/registration/controllers/registration_controller.dart';

class RegistrationView extends StatelessWidget {
  final controller = Get.put(RegistrationController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            ElevatedButton(
              onPressed: () {
                controller.register(emailController.text, passwordController.text);
              },
              child: Text('Register'),
            ),
            TextButton(onPressed: () => Get.toNamed('/login'), child: Text('Already have an account? Login'))
          ],
        ),
      ),
    );
  }
}
