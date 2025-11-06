import 'package:flutter/material.dart';

/// Manages Navigator state for TailwindComponents.
/// 
/// Uses a navigator key to access Navigator context for dialogs and overlays.
class ContextManager {
  ContextManager._();
  
  // Internal navigator key for accessing Navigator state
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// Returns the navigator key to be used with MaterialApp.
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Returns the NavigatorState from the navigator key.
  /// Returns null if Navigator hasn't been built yet.
  static NavigatorState? get navigatorState {
    return _navigatorKey.currentState;
  }
} 