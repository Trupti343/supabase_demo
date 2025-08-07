import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_demo/app/modules/login/controllers/login_controller.dart';
// import 'login_controller.dart';

class LoginView extends StatelessWidget {
  final controller = Get.put(LoginController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            ElevatedButton(
              onPressed: () {
                controller.login(emailController.text, passwordController.text);
              },
              child: Text('Login'),
            ),
            TextButton(onPressed: () => Get.toNamed('/register'), child: Text('Don\'t have an account? Register'))
          ],
        ),
      ),
    );
  }
}
