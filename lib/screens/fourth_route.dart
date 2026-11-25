// lib/screens/fourth_route.dart
import 'package:flutter/material.dart';

class FourthRoute extends StatelessWidget {
  const FourthRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Groups')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go back!'),
          onPressed: () {
            debugPrint('FourthRoute: button tapped – popping');
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}