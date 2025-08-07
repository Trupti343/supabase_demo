// import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class AuthController extends GetxController {
//   final SupabaseClient supabase = Supabase.instance.client;

 
//   Future<void> register({
//   required String email,
//   required String password, required String username,
//   }) async {
//     final response = await Supabase.instance.client.auth.signUp(
//       email: email,
//       password: password,
//     );

//     if (response.user == null) {
//       throw Exception("Registration failed");
//     }
//   }


//   Future<void> login({required String email, required String password}) async {
//     await supabase.auth.signInWithPassword(email: email, password: password);
//   }
 
//   Future<void> logout() async {
//     await supabase.auth.signOut();
//   }

//   String? get currentUserId => supabase.auth.currentUser?.id;
//   String? get currentUserEmail => supabase.auth.currentUser?.email;
// }
