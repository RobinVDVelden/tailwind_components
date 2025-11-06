import 'package:flutter/cupertino.dart';

@Deprecated('This component is no longer needed because Flutter\'s Row now has a spacing property. Use [Row] instead.')
class SpaceRow extends StatelessWidget {
  final double? spaceBetween;
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;

  const SpaceRow({super.key, this.spaceBetween = 0, required this.children, this.crossAxisAlignment, this.mainAxisAlignment, this.mainAxisSize});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    children.asMap().forEach((index, child) {
      items.add(child);

      if (index != children.length - 1) items.add(SizedBox(width: spaceBetween));
    });

    return Row(
      mainAxisSize: mainAxisSize ?? MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: items,
    );
  }
}