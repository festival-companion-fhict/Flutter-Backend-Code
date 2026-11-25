// lib/api/todo_api.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/todo.dart';
import '../services/auth_interceptor.dart';

class TodoApi {
  final String baseUrl;
  final Dio _dio = Dio();

  TodoApi({required this.baseUrl, required AuthInterceptor authInterceptor}) {
    // Attach the interceptor that adds the secret to every request
    _dio.interceptors.add(authInterceptor);

    // Optional nice logging (dev only)
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  // ---------- CREATE ----------
  Future<Todo> createTodo(Todo todo) async {
    final response = await _dio.post(
      '$baseUrl/todos',
      data: jsonEncode(todo.toJson()),
    );
    return Todo.fromJson(response.data);
  }

  // ---------- READ (list) ----------
  Future<List<Todo>> getTodos() async {
    final response = await _dio.get('$baseUrl/todos');
    final List<dynamic> raw = response.data;
    return raw.map((e) => Todo.fromJson(e as Map<String, dynamic>)).toList();
  }

  // ---------- UPDATE ----------
  Future<Todo> updateTodo(Todo todo) async {
    if (todo.id == null) {
      throw ArgumentError('Todo.id cannot be null for update');
    }
    final response = await _dio.put(
      '$baseUrl/todos/${todo.id}',
      data: jsonEncode(todo.toJson()),
    );
    return Todo.fromJson(response.data);
  }

  // ---------- DELETE ----------
  Future<void> deleteTodo(int id) async => await _dio.delete('$baseUrl/todos/$id');
}