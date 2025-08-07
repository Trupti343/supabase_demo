import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_demo/app/modules/chat/controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.messages.length,
                  itemBuilder: (_, i) {
                    final msg = controller.messages[i];
                    final isMe = msg.senderId == controller.currentUserId;

                    return GestureDetector(
                      onLongPress: () {
                        if (isMe && !msg.isDeleted) {
                          
                          Get.bottomSheet(
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Edit'),
                                    onTap: () {
                                      Get.back();
                                      final editController =
                                          TextEditingController(
                                              text: msg.content);
                                      Get.defaultDialog(
                                        title: "Edit Message",
                                        content: Column(
                                          children: [
                                            TextField(
                                              controller: editController,
                                              decoration: InputDecoration(
                                                  labelText:
                                                      'Edit your message'),
                                            ),
                                            const SizedBox(height: 10),
                                            ElevatedButton(
                                              onPressed: () {
                                                controller.editMessage(
                                                    msg.id,
                                                    editController.text);
                                                Get.back();
                                              },
                                              child: Text("Save"),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text('Delete'),
                                    onTap: () {
                                      controller.deleteMessage(msg.id);
                                      Get.back();
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.cancel),
                                    title: Text('Cancel'),
                                    onTap: () => Get.back(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (isMe && msg.isDeleted) {                        
                          Get.bottomSheet(
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.delete_forever),
                                    title: Text('Delete Permanently'),
                                    onTap: () {
                                      controller.deleteMessage(msg.id);
                                      Get.back();
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.cancel),
                                    title: Text('Cancel'),
                                    onTap: () => Get.back(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      child: Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: msg.isDeleted
                                ? Colors.grey
                                : (isMe
                                    ? Colors.blue
                                    : Colors.grey[300]),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: msg.isDeleted
                              ? Text(
                                  "Message deleted",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      msg.content,
                                      style: TextStyle(
                                        color: isMe
                                            ? Colors.white
                                            : Colors.black,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    if (msg.isEdited && !msg.isDeleted)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          '(edited)',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontStyle: FontStyle.italic,
                                            color: isMe ? Colors.white70 : Colors.black54,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                        ),
                      ),
                    );
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    decoration: InputDecoration(hintText: 'Type your message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => controller
                      .sendMessage(controller.messageController.text),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

