import 'package:flutter/material.dart';
import 'package:tailwind_components/tailwind_components.dart';
import 'package:tailwind_components_example/components/example_modal.dart';

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

  Future<void> showModal() async {
    bool? result = await ExampleModal().show<bool>();

    /// OR
    /// bool result = await Modal.show<bool>(ExampleModal());
  }

  Future<void> showToast() async {
    Toast.show('Success! ', type: ToastType.success);

    /// OR
    /// Toast.show('Info!', type: ToastType.info);
    /// Toast.show('Warning!', type: ToastType.warning);
    /// Toast.show('Error! ', type: ToastType.error);
  }

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
              onPressed: showModal,
              child: Text('Show modal'),
            ),
            
            ElevatedButton(
              onPressed: showToast,
              child: Text('Short toast'),
            ),
          ],
        ),
      ),
    );
  }
}
