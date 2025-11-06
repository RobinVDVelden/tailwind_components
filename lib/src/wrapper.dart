import 'package:flutter/material.dart';
import 'package:tailwind_components/src/theme.dart';
import 'context_manager.dart';

/// A wrapper widget that automatically initializes TailwindComponents.
/// 
/// Wrap your MaterialApp with this widget to enable all TailwindComponents features:
/// ```dart
/// TailwindComponents(
///   child: MaterialApp(
///     home: MyHomePage(),
///   ),
/// )
/// ```
class TailwindComponents extends StatefulWidget {
  final TailwindTheme theme;
  final Widget child;
  static _TailwindComponentsState? _currentState;

  const TailwindComponents({
    super.key,
    required this.child,
    TailwindTheme? theme,
  }) : theme = theme ?? const TailwindTheme();

  @override
  State<TailwindComponents> createState() => _TailwindComponentsState();

  /// Set the brightness of the theme at runtime.
  static void setBrightness(Brightness brightness) {
    final state = _currentState;
    if (state != null) {
      state._setBrightness(brightness);
    } else {
      throw Exception('TailwindComponents must be initialized before calling setBrightness');
    }
  }
}

class _TailwindComponentsState extends State<TailwindComponents> {
  late Brightness _currentBrightness;

  @override
  void initState() {
    super.initState();

    _currentBrightness = widget.theme.darkMode ? Brightness.dark : Brightness.light;

    // Register this state instance
    TailwindComponents._currentState = this;
  }

  @override
  void dispose() {
    // Clear the state reference when disposed
    if (TailwindComponents._currentState == this) {
      TailwindComponents._currentState = null;
    }
    
    super.dispose();
  }

  void _setBrightness(Brightness brightness) {
    if (_currentBrightness != brightness) {
      setState(() {
        _currentBrightness = brightness;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: ContextManager.navigatorKey,
      theme: ThemeData(
        brightness: _currentBrightness,
      ),
      home: Stack(
        children: [
          widget.child,

          /// TODO, add overlays like modals, popups etc.
        ],
      ),
      builder: (context, child) {
        ContextManager.init(context);
        
        return child!;
      },
    );
  }
} 