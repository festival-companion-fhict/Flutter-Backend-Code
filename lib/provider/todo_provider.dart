// lib/provider/todo_provider.dart
import 'package:flutter/foundation.dart';
import '../api/todo_api.dart';
import '../models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final TodoApi api;
  List<Todo> _items = [];

  List<Todo> get items => List.unmodifiable(_items);

  TodoProvider({required this.api});

  Future<void> load() async {
    _items = await api.getTodos();
    notifyListeners();
  }

  Future<void> add(String title) async {
    final created = await api.createTodo(Todo(title: title, isDone: false));
    _items.add(created);
    notifyListeners();
  }

  Future<void> toggle(Todo todo) async {
    final updated = Todo(id: todo.id, title: todo.title, isDone: !todo.isDone);
    await api.updateTodo(updated);
    final idx = _items.indexWhere((t) => t.id == todo.id);
    if (idx >= 0) {
      _items[idx] = updated;
      notifyListeners();
    }
  }

  Future<void> delete(Todo todo) async {
    if (todo.id != null) {
      await api.deleteTodo(todo.id!);
      _items.removeWhere((t) => t.id == todo.id);
      notifyListeners();
    }
  }
}