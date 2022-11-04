import 'package:app_mercury_flutter/entrypoint/blocs/provider/bloc.dart';
import 'package:app_mercury_flutter/entrypoint/blocs/provider/provider.dart';
import 'package:app_mercury_flutter/entrypoint/ui/shared/widgets/base_mixins/focus_change_mixin.dart';
import 'package:app_mercury_flutter/entrypoint/ui/shared/widgets/base_mixins/form_mixin.dart';
import 'package:flutter/material.dart';

// Mixins

abstract class BaseFormStateBloc<T extends StatefulWidget, K, Z extends Bloc>
    extends State<T> with FocusChangeMixin, FormMixin<K> {
  Z? bloc;

  BaseFormStateBloc(List<K> enumeration) {
    this.enumeration = enumeration;
  }

  @override
  void initState() {
    super.initState();
    bloc = Provider.of<Z>(getBlocInstance);
    loadFocusNodes();
    loadTextEditingControllers();
  }

  @override
  void dispose() {
    disposeFocusNodes();
    disposeTextEditingControllers();
    Provider.dispose<Z>();
    super.dispose();
  }

  Z getBlocInstance();
}
