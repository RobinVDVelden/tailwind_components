import 'package:flutter/material.dart';
import 'context_manager.dart';

/// Main wrapper widget for TailwindComponents.
/// 
/// Provides the navigator key for MaterialApp integration.
class TailwindComponents extends StatelessWidget {
  final Widget? child;

  const TailwindComponents({
    super.key,
    required this.child,
  });

  /// Navigator key to be passed to MaterialApp's navigatorKey parameter.
  /// 
  /// This is the only setup required - just pass it to MaterialApp.
  /// Modals and toasts will automatically work from anywhere in your app.
  static GlobalKey<NavigatorState> get navigatorKey => ContextManager.navigatorKey;

  @override
  Widget build(BuildContext context) {
    return child ?? const SizedBox.shrink();
  }
} 