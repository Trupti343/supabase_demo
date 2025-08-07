class Todo {
  final String id;
  final String title;
  final bool isDone;

  Todo({required this.id, required this.title, required this.isDone});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isDone: json['is_done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'is_done': isDone,
    };
  }
}
