import 'package:flutter/cupertino.dart';

@Deprecated('This component is no longer needed because Flutter\'s Column now has a spacing property. Use [Column] instead.')
class SpaceCol extends StatelessWidget {
  final double? spaceBetween;
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;

  const SpaceCol({super.key, this.spaceBetween = 0, required this.children, this.crossAxisAlignment, this.mainAxisAlignment, this.mainAxisSize});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    children.asMap().forEach((index, child) {
      items.add(child);

      if (index != children.length - 1) items.add(SizedBox(height: spaceBetween));
    });

    return Column(
      mainAxisSize: mainAxisSize ?? MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: items,
    );
  }
}