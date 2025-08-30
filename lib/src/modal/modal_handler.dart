import 'package:flutter/material.dart';
import 'package:tailwind_components/src/modal/modal.dart';

abstract class ModalHandler extends StatelessWidget {
  const ModalHandler({super.key});

  Future<T?> show<T>({bool barrierDismissible = true}) async {
    return await Modal.show<T>(this);
  }

  void close({dynamic result}) {
    Modal.close(this, result: result);
  }
}