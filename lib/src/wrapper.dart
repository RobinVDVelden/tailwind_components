import 'package:flutter/material.dart';
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
  final Widget child;

  const TailwindComponents({
    super.key,
    required this.child,
  });

  @override
  State<TailwindComponents> createState() => _TailwindComponentsState();
}

class _TailwindComponentsState extends State<TailwindComponents> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: ContextManager.navigatorKey,
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