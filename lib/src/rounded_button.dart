import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.iconData,
    this.gradient,
    this.color,
    this.onLongPress,
    this.onTap,
    required this.size,
  });

  final IconData iconData;
  final LinearGradient? gradient;
  final Color? color;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient,
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100.0),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            height: size,
            width: size,
            child: Center(
              child: Icon(iconData, size: size * 0.6, color: Colors.white)
            ),
          ),
        ),
      ),
    );
  }
}