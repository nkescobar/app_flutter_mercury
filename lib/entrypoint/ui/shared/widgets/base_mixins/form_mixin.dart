import 'package:flutter/material.dart';

mixin FormMixin<K> {
  late List<K> enumeration;
  late Map<K, FocusNode> focusNodes;
  late Map<K, TextEditingController> textEditingControllers;

  void loadFocusNodes() {
    focusNodes = {};
    for (var type in enumeration) {
      focusNodes[type] = FocusNode();
    }
  }

  void disposeFocusNodes() {
    for (var value in focusNodes.values) {
      value.dispose();
    }
  }

  void loadTextEditingControllers() {
    textEditingControllers = {};
    for (var type in enumeration) {
      textEditingControllers[type] = TextEditingController();
    }
  }

  void disposeTextEditingControllers() {
    for (var value in textEditingControllers.values) {
      value.dispose();
    }
  }
}
