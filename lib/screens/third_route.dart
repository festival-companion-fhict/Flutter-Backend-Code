// lib/screens/third_route.dart
import 'package:flutter/material.dart';

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meldingen center')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go back!'),
          onPressed: () {
            debugPrint('ThirdRoute: button tapped – popping');
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}