import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistrationController extends GetxController {
  final supabase = Supabase.instance.client;

  Future<void> register(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(email: email, password: password);
      if (response.user != null) {
        Get.snackbar('Registered', 'Confirmation email sent!');
        Get.offAllNamed('/login');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
