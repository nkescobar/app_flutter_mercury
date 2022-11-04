import 'dart:async';

abstract class Validator<Z> {
  void validate(Z dataValidate, EventSink<Z> sink);
}
