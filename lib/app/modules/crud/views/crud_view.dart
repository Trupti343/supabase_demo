import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/crud_controller.dart';

class CrudView extends StatelessWidget {
  final CrudController controller = Get.put(CrudController());
  final TextEditingController textController = TextEditingController();

  CrudView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Supabase CRUD with GetX')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
            return ListTile(
              title: Text(todo.title),
              leading: Checkbox(
                value: todo.isDone,
                onChanged: (_) => controller.updateTodo(todo),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => controller.deleteTodo(todo.id),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: 'Add Todo',
            content: TextField(controller: textController),
            textConfirm: 'Add',
            onConfirm: () {
              controller.addTodo(textController.text.trim());
              textController.clear();
              Get.back();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
