import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    required this.child,
    required this.gradient,
    required this.onPressed,
    this.width,
    this.radius,
    this.extend
  });

  final Widget child;
  final LinearGradient gradient;
  final VoidCallback onPressed;
  final double? radius;
  final double? width;
  final bool? extend;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 3.0)),
          padding: const EdgeInsets.all(0.0),
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 3.0)),
          ),
          child: Container(
            constraints: BoxConstraints(minWidth: 88.0, minHeight: 36.0),
            alignment: Alignment.center,
            child: this.child,
          ),
        ),
      ),
    );
  }
}