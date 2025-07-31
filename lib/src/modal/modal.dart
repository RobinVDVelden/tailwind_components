import 'package:flutter/material.dart';

import '../tw_wrapper.dart';

class Modal {
  static show(ModalData modalData) {
    modalEvent.value = modalData;
  }

  static void close() {
    modalEvent.value = null;
  }

  static Future<void> showModal(BuildContext context, ModalData modalData) async {
    await showDialog<void> (
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            titlePadding: const EdgeInsets.all(0),
            title: Container(
              decoration: BoxDecoration(
                boxShadow: modalData.header.enableShadow ? <BoxShadow>[
                  const BoxShadow(
                      color: Colors.black54,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 0.75)
                  ),
                ] : [],
                color: modalData.header.color,
                gradient: modalData.header.gradient,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: modalData.header.mainAxisAlignment ?? MainAxisAlignment.start,
                children: modalData.header.children,
              ),
            ),
            content: modalData.body,
            actions: modalData.actions,
          );
        });
      },
    );
  }
}

class ModalData {
  final ModalHeader header;
  final Widget body;
  final List<Widget> actions;

  ModalData({required this.header, required this.body, required this.actions});
}

class ModalHeader {
  final MainAxisAlignment? mainAxisAlignment;
  final List<Widget> children;
  final Color? color;
  final Gradient? gradient;
  final bool enableShadow;

  ModalHeader({this.mainAxisAlignment, required this.children, this.color, this.gradient, this.enableShadow = false});
}