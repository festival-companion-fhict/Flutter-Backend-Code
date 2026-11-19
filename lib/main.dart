import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// ---------------------------------------------------------------------
/// Root widget – creates the Material‑style environment (Theme, Direction,
/// Navigator, etc.)
/// ---------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Two‑Page Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),

      // You could also define named routes here (see the optional section
      // at the bottom of this answer).
      home: const FirstRoute(),
    );
  }
}

/// ---------------------------------------------------------------------
/// First screen – the place where we press the button to go to the second
/// screen.
/// ---------------------------------------------------------------------
class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Route')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //Button 1
          children: [ElevatedButton(
          child: const Text('Open Second Route'),
          onPressed: () {
            debugPrint('FirstRoute: button tapped – pushing SecondRoute');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SecondRoute()),
            );
          },
        ),
        const SizedBox(height: 20),
            const Text(
              'Plattegrond.',
              textAlign: TextAlign.center,
            ),
          
          //End button1
          ElevatedButton(
          child: const Text('Open Third Route'),
          onPressed: () {
            debugPrint('3rdRoute: button tapped – pushing ThirdRoute');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ThirdRoute()),
            );
          },
        ),
        const SizedBox(height: 20),
            const Text(
              'Meldingen center.',
              textAlign: TextAlign.center,
            ),
        ElevatedButton(
          child: const Text('Open Fourth Route'),
          onPressed: () {
            debugPrint('FirstRoute: button tapped – pushing FourthRoute');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FourthRoute()),
            
            );
          },
        ),
        const SizedBox(height: 20),
            const Text(
              'Groups.',
              textAlign: TextAlign.center,
            ),
          ],
    )
      ),
    );
  }
}

/// ---------------------------------------------------------------------
/// Second screen 
/// ---------------------------------------------------------------------
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