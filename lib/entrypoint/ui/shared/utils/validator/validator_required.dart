import 'dart:async';

import 'package:app_mercury_flutter/entrypoint/ui/shared/utils/validator/validator.dart';

class RequiredValidator<Z> implements Validator<Z> {
  final String? mensaje;
  RequiredValidator({this.mensaje});

  @override
  void validate(Z? dataValidate, EventSink<Z> sink) {
    if (dataValidate == null) {
      return sink.addError(mensaje ?? 'El campo es requerido');
    } else if (dataValidate is String) {
      return dataValidate.isEmpty || dataValidate.trim().isEmpty
          ? sink.addError(mensaje ?? 'El campo es requerido')
          : sink.add(dataValidate);
    } else {
      return sink.add(dataValidate);
    }
  }
}
