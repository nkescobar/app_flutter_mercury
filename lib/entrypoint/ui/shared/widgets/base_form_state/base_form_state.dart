import 'package:flutter/material.dart';

import '../base_mixins/focus_change_mixin.dart';
import '../base_mixins/form_mixin.dart';

// Mixins

abstract class BaseFormState<T extends StatefulWidget, K> extends State<T>
    with FocusChangeMixin, FormMixin<K> {
  BaseFormState(List<K> enumeration) {
    this.enumeration = enumeration;
  }

  @override
  void initState() {
    super.initState();
    loadFocusNodes();
    loadTextEditingControllers();
  }

  @override
  void dispose() {
    disposeFocusNodes();
    disposeTextEditingControllers();
    super.dispose();
  }
}
