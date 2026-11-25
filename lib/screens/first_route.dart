// lib/screens/first_route.dart
import 'package:flutter/material.dart';
import 'second_route.dart';
import 'third_route.dart';
import 'fourth_route.dart';

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    // You could call _loadTodos(context) here with a FutureBuilder,
    // a stateful widget, or a Riverpod provider – it’s just an example.
    return Scaffold(
      appBar: AppBar(title: const Text('First Route')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('Open Second Route'),
              onPressed: () {
                debugPrint(
                    'FirstRoute: button tapped – pushing SecondRoute');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SecondRoute()),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text('Plattegrond.', textAlign: TextAlign.center),

            ElevatedButton(
              child: const Text('Open Third Route'),
              onPressed: () {
                debugPrint(
                    'ThirdRoute: button tapped – pushing ThirdRoute');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ThirdRoute()),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text('Meldingen center.', textAlign: TextAlign.center),

            ElevatedButton(
              child: const Text('Open Fourth Route'),
              onPressed: () {
                debugPrint(
                    'FirstRoute: button tapped – pushing FourthRoute');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FourthRoute()),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text('Groups.', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}