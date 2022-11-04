import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:app_mercury_flutter/entrypoint/blocs/provider/index.dart'
    show Bloc;
import 'package:app_mercury_flutter/entrypoint/ui/screens/index.dart'
    show CategoriesTextFielTypeEnum;
import 'package:app_mercury_flutter/entrypoint/ui/shared/index.dart'
    show FieldStream, RequiredValidator, ValidateAllStreamsHaveDataAndNoErrors;

class CategoryBloc with Bloc {
  late Map<CategoriesTextFielTypeEnum, FieldStream> $streams;
  late List<StreamSubscription> subscriptions;

  final BehaviorSubject<bool> _loadingCategory =
      BehaviorSubject<bool>.seeded(false);
  ValueStream<bool> get $loadingCategory => _loadingCategory.stream;

  ValidateAllStreamsHaveDataAndNoErrors? _validateAllStreamsHaveDataAndNoErrors;
  Stream<bool>? get $formularioValido =>
      _validateAllStreamsHaveDataAndNoErrors?.status;

  CategoryBloc() {
    subscriptions = [];
  }

  @override
  void init() {
    _loadStreams();
    _loadValidators();
    _listenValidateAllStreamsHaveDataAndNoErrors();
  }

  @override
  void dispose() {
    _disposeValidateAllStreamsHaveDataAndNoErrors();
    _cancelSuscriptions();
    _disposeStreams();
    _closeLoadingCategory();
  }

  void _loadStreams() {
    $streams = {};
    $streams[CategoriesTextFielTypeEnum.name] = FieldStream<String>([
      RequiredValidator<String>(),
    ]);
    $streams[CategoriesTextFielTypeEnum.description] = FieldStream<String>([
      RequiredValidator<String>(),
    ]);
  }

  void _loadValidators() {
    for (var stream in $streams.values) {
      stream.setValidatorsFields();
    }
  }

  void _listenValidateAllStreamsHaveDataAndNoErrors() {
    var streamsList =
        $streams.values.map((stream) => stream.$streamField).toList();

    _validateAllStreamsHaveDataAndNoErrors =
        ValidateAllStreamsHaveDataAndNoErrors()..listen(streamsList);
  }

  void _closeLoadingCategory() {
    _loadingCategory.close();
  }

  void _disposeStreams() {
    for (var value in $streams.values) {
      value.dispose();
    }
  }

  void _cancelSuscriptions() {
    for (var value in subscriptions) {
      value.cancel();
    }
  }

  void _disposeValidateAllStreamsHaveDataAndNoErrors() {
    _validateAllStreamsHaveDataAndNoErrors?.dispose();
  }

  void validateFormAndShowErrors() {
    for (var type in $streams.values) {
      if (type.valueType == String) {
        type.onChangeField(
            type.fieldController.hasValue ? type.fieldController.value : '');
      } else {
        type.onChangeField(
            type.fieldController.hasValue ? type.fieldController.value : null);
      }
    }
  }

  void _hideLoadingCategory() {
    verifySinkAddStream(_loadingCategory, () {
      _loadingCategory.value = false;
    });
  }

  void _showLoadingCategory() {
    verifySinkAddStream(_loadingCategory, () {
      _loadingCategory.value = true;
    });
  }
}
