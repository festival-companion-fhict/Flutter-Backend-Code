// lib/first_route.dart
import 'package:flutter/material.dart';
import '../api/todo_api.dart';

class FirstRoute extends StatelessWidget {
  final TodoApi todoApi;             // <-- receive it

  const FirstRoute({super.key, required this.todoApi});

  // … rest of your UI (unchanged) …
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Festival Buddy')),
    );
  }
}
