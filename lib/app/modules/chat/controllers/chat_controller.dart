import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../model/chatModel.dart';

class ChatController extends GetxController {
  final supabase = Supabase.instance.client;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final RxList<Message> messages = <Message>[].obs;

  late final String currentUserId;
  late final String toUserId;
  late RealtimeChannel channel;

  @override
  void onInit() {
    super.onInit();
    currentUserId = supabase.auth.currentUser!.id;
    toUserId = Get.arguments['toUserId'];
    fetchMessages();
    subscribeToMessages();
  }

  void fetchMessages() async {
    final response = await supabase
        .from('messages')
        .select()
        .or(
          'and(sender_id.eq.$currentUserId,receiver_id.eq.$toUserId),and(sender_id.eq.$toUserId,receiver_id.eq.$currentUserId)',
        )
        .order('created_at', ascending: true);

    final List data = response;
    messages.value = data.map((e) => Message.fromMap(e)).toList();
    scrollToBottom();
  }

  void subscribeToMessages() {
    channel = supabase.channel('public:messages')
      .onPostgresChanges(
        event: PostgresChangeEvent.insert,
        schema: 'public',
        table: 'messages',
        callback: (payload, [ref]) {
          final msg = Message.fromMap(payload.newRecord);
          if ((msg.senderId == currentUserId && msg.receiverId == toUserId) ||
              (msg.senderId == toUserId && msg.receiverId == currentUserId)) {
            messages.add(msg);
            WidgetsBinding.instance
                .addPostFrameCallback((_) => scrollToBottom());
          }
        },
      )
      .onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'messages',
        callback: (payload, [ref]) {
          final updatedMsg = Message.fromMap(payload.newRecord);
          final index = messages.indexWhere((m) => m.id == updatedMsg.id);
          if (index != -1) {
            messages[index] = updatedMsg;
          }
        },
      )
      .subscribe();
  }

  void sendMessage(String content) async {
    if (content.trim().isEmpty) return;
    await supabase.from('messages').insert({
      'sender_id': currentUserId,
      'receiver_id': toUserId,
      'content': content.trim(),
    });
    messageController.clear();
  }

  void deleteMessage(String messageId) async {
   
    final msg = messages.firstWhereOrNull((m) => m.id == messageId);
    if (msg == null) return;
    if (msg.isDeleted) {
     
      await hardDeleteMessage(messageId);
    } else {
    
      await supabase
          .from('messages')
          .update({'is_deleted': true})
          .eq('id', messageId);
    }
  }

  Future<void> hardDeleteMessage(String messageId) async {
    await supabase
        .from('messages')
        .delete()
        .eq('id', messageId);
    messages.removeWhere((m) => m.id == messageId);
  }

  void editMessage(String messageId, String newContent) async {
    if (newContent.trim().isEmpty) return;
    await supabase.from('messages').update({
      'content': newContent.trim(),
      'is_edited': true, 
    }).eq('id', messageId);
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    channel.unsubscribe();
    messageController.dispose();
    super.onClose();
  }
}
