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
      theme: TailwindTheme(darkMode: true),
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

  Future<void> showShortSuccessToast() async {
    Toast.show('Success! ', type: ToastType.success);

    /// OR
    /// Toast.show('Info!', type: ToastType.info);
    /// Toast.show('Warning!', type: ToastType.warning);
    /// Toast.show('Error! ', type: ToastType.error);
  }

  Future<void> showLongSuccessToast() async {
    Toast.show('Success! This Toast includes a long string for demonstration!', type: ToastType.success);
  }

  Future<void> showErrorToast() async {
    Toast.show('Error! ', type: ToastType.error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tailwind Components'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Modals',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton(
                  onPressed: showModal,
                  child: Text('Show modal'),
                ),
              ],
            ),
        
            const SizedBox(height: 30),
        
            Text(
              'Toasts',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton(
                  onPressed: showShortSuccessToast,
                  child: Text('Short success toast'),
                ),
        
                ElevatedButton(
                  onPressed: showLongSuccessToast,
                  child: Text('Long success toast'),
                ),
        
                ElevatedButton(
                  onPressed: showErrorToast,
                  child: Text('Error toast'),
                ),
              ],
            ),
        
            const SizedBox(height: 30),

            Text(
              'Set Brightness',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () {
                    TailwindComponents.setBrightness(Brightness.dark);
                  },
                  child: Text('Set dark mode'),
                ),
                ElevatedButton(
                  onPressed: () {
                    TailwindComponents.setBrightness(Brightness.light);
                  },
                  child: Text('Set light mode'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
