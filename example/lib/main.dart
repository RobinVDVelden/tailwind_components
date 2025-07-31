import 'package:flutter/material.dart';
import 'package:tailwind_components/tailwind_components.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TailwindComponents(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const BaseApp(),
      ),
    );
  }
}

class BaseApp extends StatefulWidget {
  const BaseApp({super.key});

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tailwind Components'),
      ),
      body: Center(
        child: Wrap(
          spacing: 12,
          children: [
            ElevatedButton(
              child: Text('Toast with a very long message'),
              onPressed: () => Toast.show('Successfully!', type: ToastType.success),
            )
          ],
        ),
      ),
    );
  }
}
