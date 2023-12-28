import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AutoGrid extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final List<Widget> children;
  final int amountCols;
  final double gap;

  AutoGrid({super.key, required this.children, required this.amountCols, required this.gap});

  List<List<Widget>> get separatedItems {
    List<List<Widget>> items = [];

    for (int i = 0; i < children.length; i += amountCols) {
      int endIndex = i + amountCols;
      if (endIndex > children.length) {
        endIndex = children.length;
      }
      items.add(children.sublist(i, endIndex));
    }

    return items;
  }

  List<Widget> getRowWidgets(List<Widget> items) {
    List<Widget> widgets = [];

    while (items.length != amountCols) {
      items.add(const SizedBox());
    }

    for (Widget item in items) {
      widgets.add(Expanded(child: item));

      if (items.indexOf(item) != (items.length - 1)) {
        widgets.add(SizedBox(width: gap));
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: separatedItems.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: gap),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: getRowWidgets(separatedItems[index]),
            ),
          ),
        );
      },
    );
  }
}
