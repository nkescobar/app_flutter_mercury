import 'package:app_mercury_flutter/entrypoint/blocs/provider/bloc.dart';
import 'package:app_mercury_flutter/entrypoint/blocs/provider/provider.dart';
import 'package:app_mercury_flutter/entrypoint/ui/shared/widgets/base_mixins/focus_change_mixin.dart';
import 'package:flutter/material.dart';

// Mixins

// Blocs

abstract class BaseStateBloc<T extends StatefulWidget, Z extends Bloc>
    extends State<T> with FocusChangeMixin {
  late Z? bloc;

  BaseStateBloc();

  @override
  void initState() {
    super.initState();
    bloc = Provider.of<Z>(getBlocInstance);
  }

  @override
  void dispose() {
    Provider.dispose<Z>();
    super.dispose();
  }

  Z getBlocInstance();
}
