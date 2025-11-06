import 'package:flutter/material.dart';
import 'package:tailwind_components/src/toast/toast_chip.dart';
import '../context_manager.dart';
import 'toast_type_enum.dart';

/// Global toast manager for showing toast notifications from anywhere in the app.
/// 
/// Usage:
/// ```dart
/// Toast.show('Your message here');
/// Toast.show('Success!', ToastType.success);
/// Toast.show('Warning!', ToastType.warning);
/// Toast.show('Error!', ToastType.error);
/// Toast.show('Info!', ToastType.info);
/// ```
class Toast {
  // Current toast overlay entry (only one toast shown at a time)
  static OverlayEntry? _currentToast;

  /// Shows a toast message with the specified type.
  /// 
  /// If a toast is already showing, it will be replaced.
  /// Default type is [ToastType.info].
  static void show(String message, {ToastType type = ToastType.info}) {
    // Remove existing toast if any
    _currentToast?.remove();
    
    try {
      final navigatorState = ContextManager.navigatorState;
      if (navigatorState == null) {
        throw Exception('Navigator not available');
      }

      _currentToast = OverlayEntry(
        builder: (context) => Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ToastChip(
            message: message,
            type: type,
            onDismiss: () {
              _currentToast?.remove();
              _currentToast = null;
            },
          ),
        ),
      );

      navigatorState.overlay?.insert(_currentToast!);
    } catch (e) {
      throw Exception(
        'TailwindComponents not properly initialized. '
        'Make sure to add navigatorKey: TailwindComponents.navigatorKey to your MaterialApp.'
      );
    }
  }
}