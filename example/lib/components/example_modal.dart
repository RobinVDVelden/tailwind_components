import 'package:flutter/material.dart';
import "package:tailwind_components/tailwind_components.dart";

class ExampleModal extends ModalHandler {
  const ExampleModal({super.key});

  @override
  Widget build(BuildContext context) {
    return TWModal(
      maxWidth: 350,

      title: const Text('Example Modal'),
      actions: [
        IconButton(
          onPressed: close,
          icon: Icon(Icons.close, size: 16),
        ),
      ],

      body: Text('Close() function is available with a result parameter within ModalHandler.'),

      footer: Row(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => close(),
          ),

          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () => close(result: true),
          ),
        ],
      ),
    );
  }
}
