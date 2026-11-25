// lib/models/todo.dart
class Todo {
  final int? id;
  final String title;
  final bool isDone;

  Todo({
    this.id,
    required this.title,
    required this.isDone,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'] as int?,
        title: json['title'] as String,
        isDone: json['isDone'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isDone': isDone,
      };
}