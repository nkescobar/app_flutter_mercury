// Enumeraciones
import 'package:app_mercury_flutter/core/enums/index.dart' show StatusEnum;

// Modelos
import 'package:app_mercury_flutter/core/models/index.dart'
    show CustomErrorResult;

class ResultadoUI<T> {
  T? data;
  StatusEnum? status;
  CustomErrorResult? error;
  Map<String, String>? errors;
  String? successMessages;

  ResultadoUI.success(this.data, {this.successMessages}) {
    status = StatusEnum.success;
    errors = null;
    error = null;
  }

  ResultadoUI.error({
    String? message,
    int code = 0,
    CustomErrorResult? error,
    Map<String, String>? errors,
  }) {
    status = StatusEnum.error;
    _setErrores(message, code, error, errors);
  }

  ResultadoUI.unauthorized({
    String? message,
    int code = 0,
    CustomErrorResult? error,
    Map<String, String>? errors,
  }) {
    status = StatusEnum.unauthorized;
    _setErrores(message, code, error, errors);
  }

  void _setErrores(
    String? message,
    int code,
    CustomErrorResult? error,
    Map<String, String>? errors,
  ) {
    this.error = error ??
        CustomErrorResult(
          message: message,
          code: code,
        );

    this.errors = errors ?? {};
    successMessages = null;
  }
}
