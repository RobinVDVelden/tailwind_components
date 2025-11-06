import 'package:flutter/material.dart';
import 'package:tailwind_components/tailwind_components.dart';

class Modal {  
  static final Map<int, BuildContext> _modals = {};
  
  static Future<T?> show<T>(ModalHandler modal) async {   
    var result = await showDialog<T> (
      context: ContextManager.navigatorKey.currentState!.context,
      builder: (BuildContext context) {
        /// Add the context to the Modals list
        _modals[modal.hashCode] = context;

        return modal;
      },
    );
    
    _modals.remove(modal);
    
    return result;
  }
  
  static void close(ModalHandler modal, { dynamic result }) {
    BuildContext? modalContext = _modals[modal.hashCode];

    if (modalContext != null) {
      Navigator.of(modalContext).pop(result);
    }
  }
}