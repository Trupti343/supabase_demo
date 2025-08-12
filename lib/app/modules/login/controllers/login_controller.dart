// import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class LoginController extends GetxController {
//   final supabase = Supabase.instance.client;

//   Future<void> login(String email, String password) async {
//     try {
//       final response = await supabase.auth.signInWithPassword(email: email, password: password);
//       if (response.user != null) {
//         Get.offAllNamed('/users');
//       }
//     } catch (e) {
//       Get.snackbar('Login Failed', e.toString());
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  final supabase = Supabase.instance.client;

  Future<void> loginWithEmail(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );
      if (response.user != null) {
        Get.offAllNamed('/users');
      }
    } catch (e) {
      final message = (e is AuthException) ? e.message : 'Login failed';
      Get.snackbar('Error', message);
    }
  }

  // Future<void> loginWithGoogle() async {
  //   try {
  //     // await supabase.auth.signInWithOAuth(
  //     //   OAuthProvider.google,
  //     //   redirectTo: 'io.supabase.flutter://login-callback',
  //     //   // redirectTo: 'https://mvxjzbquhnvgmqvmktiw.supabase.co/auth/v1/callback',
       
  //     // );

  //     await supabase.auth.signInWithOAuth(
  //       OAuthProvider.google,
  //       redirectTo: 'io.supabase.flutter://login-callback',
  //     );

  //   } catch (e) {
  //     final message = (e is AuthException) ? e.message : 'Google login failed';
  //     Get.snackbar('Google Login Failed', message);
  //   }
  // }
  Future<void> loginWithGoogle() async {
    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.flutter://login-callback',
      );
    } catch (e) {
      print('Google Login Exception: $e');
      Get.snackbar('Login Failed', e.toString());
    }
  }  
}