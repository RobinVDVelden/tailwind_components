import 'package:flutter/material.dart';

/// Global context manager for TailwindComponents package.
/// 
/// Initialize this at the top level of your Flutter app:
/// ```dart
/// TailwindComponents.init(context);
/// ```
class ContextManager {
  ContextManager._();
  
  static BuildContext? _context;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Initialize the global context for the package.
  /// Call this at the top level of your Flutter app.
  static void init(BuildContext context) {
    _context = context;
  }

  /// Get the global context.
  /// Throws an exception if not initialized.
  static BuildContext get context {
    if (_context == null) {
      throw Exception('TailwindComponents must be initialized at the top level of your Flutter app before using any components: TailwindComponents.init(context);');
    }
    return _context!;
  }
} 