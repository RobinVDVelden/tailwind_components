import 'package:flutter/material.dart';
import 'package:tailwind_components/tailwind_components.dart';

/// Global modal manager for showing dialogs from anywhere in the app.
class Modal {  
  // Maps modal instances to their dialog contexts for closing
  static final Map<int, BuildContext> _modals = {};
  
  /// Shows a modal dialog using the global Navigator context.
  /// 
  /// Returns the result value when the modal is closed.
  static Future<T?> show<T>(ModalHandler modal) async {
    try {
      final navigatorState = ContextManager.navigatorState;
      if (navigatorState == null) {
        throw Exception('Navigator not available');
      }
      
      final result = await showDialog<T>(
        context: navigatorState.context,
        builder: (BuildContext context) {
          // Store modal context for programmatic closing
          _modals[modal.hashCode] = context;
          return modal;
        },
      );
      
      // Clean up when dialog closes
      _modals.remove(modal.hashCode);
      return result;
    } catch (e) {
      throw Exception(
        'TailwindComponents not properly initialized. '
        'Make sure to add navigatorKey: TailwindComponents.navigatorKey to your MaterialApp.'
      );
    }
  }
  
  /// Closes a modal dialog programmatically.
  /// 
  /// Optionally returns a result value.
  static void close(ModalHandler modal, {dynamic result}) {
    final modalContext = _modals[modal.hashCode];
    if (modalContext != null) {
      Navigator.of(modalContext).pop(result);
    }
  }
}