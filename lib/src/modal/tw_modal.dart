import 'package:flutter/material.dart';

class TWModal extends StatelessWidget {
  final double? maxWidth;
  final double? maxHeight;
  final double verticalInsetsPadding;

  /// Header
  final Widget? title;
  final bool centerTitle;
  final Widget? leading;
  final List<Widget>? actions;

  final Widget? body;
  final Widget? expandedBody;

  final Widget? footer;

  const TWModal({
    this.maxWidth,
    this.verticalInsetsPadding = 25,
    this.maxHeight,
    this.body,
    this.footer,
    this.expandedBody,
    this.title,
    this.centerTitle = false,
    this.leading,
    this.actions,
    super.key,
  }) : assert(!(body != null && expandedBody != null),
            'Only one of body or expandedBody can be provided');

  Widget get _headerWidget {
    return Container(
      padding: EdgeInsets.only(
        top: 5,
        left: 20,
        right: actions != null ? 10 : 20,
      ),
      constraints: const BoxConstraints(
        minHeight: 60,
      ),
      child: Row(
        spacing: 12,
        children: [
          if (leading != null) leading!,

          if (title != null) Expanded(
            child: Row(
              mainAxisAlignment: centerTitle
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                  child: title!,
                )
              ],
            ),
          ),

          if (actions != null) Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: actions!,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<double> keyboardInset =
        ValueNotifier(MediaQuery.of(context).viewInsets.bottom);

    return SafeArea(
      child: AnimatedBuilder(
        animation: keyboardInset,
        builder: (context, _) {
          double verticalPadding = (verticalInsetsPadding) -
              (keyboardInset.value / 10).clamp(0, verticalInsetsPadding);

          verticalPadding += 20;

          double topPadding = verticalPadding;
          double bottomPadding = verticalPadding;

          return Dialog(
            insetPadding: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: bottomPadding,
              top: topPadding,
            ),
            backgroundColor: Colors.transparent,
            child: Container(
              constraints: (maxWidth != null || maxHeight != null)
                  ? BoxConstraints(
                      maxWidth: maxWidth ?? double.infinity,
                      maxHeight: maxHeight ?? double.infinity,
                    )
                  : null,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white.withValues(alpha: .1)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 8,
                      blurRadius: 12,
                      offset: Offset(0, 0),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null || actions != null || leading != null) _headerWidget,

                  if (body != null)
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 30,
                          left: 20,
                          right: 20,
                        ),
                        child: body,
                      ),
                    ),
                  if (expandedBody != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: expandedBody,
                      ),
                    ),

                  if (footer != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: footer!,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
