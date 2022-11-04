import 'dart:async';
// RxDart
import 'package:rxdart/rxdart.dart';

import 'package:app_mercury_flutter/entrypoint/ui/shared/index.dart'
    show Validator;

// Base Validators

class FieldStream<T> {
  final BehaviorSubject<T> fieldController = BehaviorSubject<T>();
  Function(T) get onChangeField => fieldController.sink.add;
  Stream<T>? $streamField;
  List<Validator> validators;
  Type valueType;

  FieldStream(
    this.validators, {
    this.valueType = String,
  }) : assert(T != dynamic, 'No se puede crear un stream de tipo dynamic');

  void dispose() {
    fieldController.close();
  }

  void setValidatorsFields() {
    _resetStream();
    for (var validation in validators) {
      StreamTransformer<T, T> transformer =
          StreamTransformer<T, T>.fromHandlers(handleData: validation.validate);
      $streamField = $streamField!.transform(transformer);
    }
  }

  void _resetStream() {
    $streamField = fieldController.stream;
  }
}
