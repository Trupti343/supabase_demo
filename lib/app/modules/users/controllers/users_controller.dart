import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsersController extends GetxController {
  final supabase = Supabase.instance.client;
  final RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;
  late final String currentUserId;

  @override
  void onInit() {
    super.onInit();
    currentUserId = supabase.auth.currentUser!.id;
    fetchUsers();
  }

  void fetchUsers() async {
    final response = await supabase.from('profiles').select();
    users.value = response.where((user) => user['id'] != currentUserId).toList();
  }

  void startChat(String toUserId) {
    Get.toNamed('/chat', arguments: {'toUserId': toUserId});
  }
}
      