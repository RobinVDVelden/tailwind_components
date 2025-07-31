import 'package:flutter/material.dart';
import '../context_manager.dart';
import 'custom_toast.dart';
import 'toast_type.dart';

/// Global toast instance for showing custom toast messages.
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
  static OverlayEntry? _currentToast;

  /// Show a custom toast message with optional type.
  /// Default type is info.
  static void show(String message, {ToastType type = ToastType.info}) {
    // Remove existing toast if any
    _currentToast?.remove();
    
    final navigatorState = ContextManager.navigatorKey.currentState;
    if (navigatorState == null) {
      throw Exception('MaterialApp must be initialized with navigatorKey');
    }

    _currentToast = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: CustomToast(
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
  }
}