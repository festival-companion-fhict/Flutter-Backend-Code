// lib/screens/second_route.dart
import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Map')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go back!'),
          onPressed: () {
            debugPrint('SecondRoute: button tapped – popping');
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}