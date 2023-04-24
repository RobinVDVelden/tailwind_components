import 'package:flutter/material.dart';

class GradientAppBar extends AppBar {
  final Gradient gradient;

  GradientAppBar({
    super.key,
    required this.gradient,
    Widget? title,
    bool? centerTitle,
    List<Widget>? actions,
    Widget? leading,
    double? elevation,
    Color? foregroundColor,
    Color? shadowColor,
    ShapeBorder? shape,

  }): super(
    title: title,
    centerTitle: centerTitle,
    elevation: elevation,
    actions: actions,
    leading: leading,
    shadowColor: shadowColor,
    shape: shape,
  );

  @override
  Widget? get flexibleSpace => Container(
    decoration: BoxDecoration(
      gradient: gradient,
    ),
  );
}