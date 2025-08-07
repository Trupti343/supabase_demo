import 'package:get/get.dart';
import 'package:supabase_demo/app/model/todo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import '../models/todo_model.dart';

class CrudController extends GetxController {
  final supabase = Supabase.instance.client;

  var todos = <Todo>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    isLoading.value = true;
    final response = await supabase.from('todos').select();
    todos.value = response.map((json) => Todo.fromJson(json)).toList();
    isLoading.value = false;
  }

  Future<void> addTodo(String title) async {
    await supabase.from('todos').insert({'title': title, 'is_done': false});
    fetchTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    await supabase.from('todos')
        .update({'is_done': !todo.isDone})
        .eq('id', todo.id);
    fetchTodos();
  }

  Future<void> deleteTodo(String id) async {
    await supabase.from('todos').delete().eq('id', id);
    fetchTodos();
  }
}
