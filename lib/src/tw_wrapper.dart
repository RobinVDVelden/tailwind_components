import 'package:flutter/material.dart';

import 'modal.dart';

ValueNotifier<ModalData?> modalEvent = ValueNotifier(null);

class TWWrapper extends StatefulWidget {
  final Widget child;

  const TWWrapper({super.key, required this.child});

  @override
  _TWWrapperState createState() => _TWWrapperState();
}

class _TWWrapperState extends State<TWWrapper> {
  late Function() listenerFunction;
  bool modalOpen = false;

  @override
  void initState() {
    super.initState();

    initListener();
  }

  void initListener() {
    listenerFunction = () async {
      if (modalEvent.value != null) {
        triggerModal();
        return;
      }

      if (modalOpen) {
        Navigator.of(context).pop();
      }
    };

    modalEvent.addListener(listenerFunction);
  }

  void triggerModal() async {
    modalOpen = true;
    await Modal.showModal(context, modalEvent.value!);
    modalOpen = false;
  }

  @override
  void dispose() {
    super.dispose();
    modalEvent.removeListener(listenerFunction);
  }

  @override
  Widget build(BuildContext dialogContext) {
    return widget.child;
  }
}
