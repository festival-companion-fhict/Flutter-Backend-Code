// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'api/todo_api.dart';
import 'services/auth_interceptor.dart';
import 'config/app_config.dart';
import 'config/config_dev.dart';   // <-- swap with config_prod.dart for prod

Future<void> main() async {
  // -------------------------------------------------
  // 1️⃣ Load .env (optional – safe to call even if you
  //    don't have a file, it just does nothing)
  // -------------------------------------------------
  await dotenv.load();

  // -------------------------------------------------
  // 2️⃣ Resolve the base URL.
  //    Order of precedence:
  //      a) env var (e.g. `flutter run --dart-define=BASE_URL=…`)
  //      b) .env file
  //      c) hard‑coded devConfig fallback
  // -------------------------------------------------
  const AppConfig fallback = devConfig; // <-- change to prodConfig for a prod build
  final String baseUrl = dotenv.maybeGet('BASE_URL') ?? fallback.baseUrl;

  // -------------------------------------------------
  // 3️⃣ Build the singleton TodoApi (and the interceptor it needs)
  // -------------------------------------------------
  final TodoApi todoApi = TodoApi(
    baseUrl: baseUrl,
    authInterceptor: AuthInterceptor(),
  );

  // -------------------------------------------------
  // 4️⃣ Provide the API to the entire widget tree.
  //    Provider is cheap – it just holds the reference.
  // -------------------------------------------------
  runApp(
    Provider<TodoApi>.value(
      value: todoApi,
      child: const MyApp(),
    ),
  );
}

// -------------------------------------------------------------------
// Root widget – stays tiny; any screen can obtain TodoApi via Provider
// -------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Two‑Page Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      // The first screen is the entry point of the navigation stack.
      home: FirstRoute(todoApi: context.read<TodoApi>()),
    );
  }
}
/// ---------------------------------------------------------------------
/// First screen – the place where we press the button to go to the second
/// screen.
/// ---------------------------------------------------------------------
class FirstRoute extends StatelessWidget {
  final TodoApi todoApi;

  const FirstRoute({super.key, required this.todoApi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Go to Live Map, Meldingen center, or Groups')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //Button 1
          children: [ElevatedButton(
          child: const Text('Go to Live Map!'),
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
          child: const Text('Go to Meldingen center!'),
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
          child: const Text('Go to groups!'),
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
      appBar: AppBar(title: const Text('Meldingen center main')),
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