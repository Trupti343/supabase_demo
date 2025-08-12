// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:supabase_demo/app/modules/login/controllers/login_controller.dart';
// // import 'login_controller.dart';

// class LoginView extends StatelessWidget {
//   final controller = Get.put(LoginController());
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
//             TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
//             ElevatedButton(
//               onPressed: () {
//                 controller.login(emailController.text, passwordController.text);
//               },
//               child: Text('Login'),
//             ),
//             TextButton(onPressed: () => Get.toNamed('/register'), child: Text('Don\'t have an account? Register'))
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.loginWithEmail(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: Text('Login with Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.login),
              label: Text("Sign in with Google"),
              onPressed: controller.loginWithGoogle,
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () => Get.toNamed('/registration'),
              child: Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}