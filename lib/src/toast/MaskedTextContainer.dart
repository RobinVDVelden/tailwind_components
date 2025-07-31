import 'package:flutter/material.dart';

class MaskedTextContainer extends StatelessWidget {
  final double width;
  final double maxTextWidth;
  final String text;

  const MaskedTextContainer({
    super.key,
    required this.width,
    required this.maxTextWidth,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context).style;

    final textPainter = TextPainter(
      text: TextSpan(text: text, style: defaultTextStyle),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxTextWidth);

    final fixedHeight = textPainter.height;

    return Container(
      width: width,
      height: fixedHeight,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              width: maxTextWidth,
              child: DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
                child: Text(
                  text,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}