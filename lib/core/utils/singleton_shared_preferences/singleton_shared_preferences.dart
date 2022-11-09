// ignore_for_file: recursive_getters

import 'dart:async';

import 'package:app_mercury_flutter/entrypoint/application/config/index.dart'
    show AppConstants;

// Strings y Routes

abstract class MySingletonSharedPreferences {
  String? get token => token;

  set token(String? token);

  String? get paginaActual => paginaActual;

  set paginaActual(String? paginaActual);

  String? get nombreCompletoAsesor => nombreCompletoAsesor;

  set nombreCompletoAsesor(String? nombreCompletoAsesor);

  StreamController<bool>? get $logoutController;

  set $logoutController(StreamController<bool>? logoutController);

  void closeLogoutStreamController();

  StreamController<bool>? get $inactividadController;

  set $inactividadController(StreamController<bool>? inactividadController);

  void closeInactividadStreamController();

  void initializeTimer();

  Timer? get timer => timer;

  set timer(Timer? token);

  bool? get primeraConsultaVectorExterno => primeraConsultaVectorExterno;

  set primeraConsultaVectorExterno(bool? primeraConsultaVectorExterno);
}

class MySingletonSharedPreferencesImpl implements MySingletonSharedPreferences {
  static final MySingletonSharedPreferencesImpl _singleton =
      MySingletonSharedPreferencesImpl._internal();

  factory MySingletonSharedPreferencesImpl() {
    return _singleton;
  }

  MySingletonSharedPreferencesImpl._internal() {
    $logoutController = StreamController<bool>.broadcast();
    $inactividadController = StreamController<bool>.broadcast();
  }

  @override
  String? token;

  @override
  String? paginaActual;

  @override
  String? nombreCompletoAsesor;

  @override
  Timer? timer;

  @override
  StreamController<bool>? $logoutController;

  @override
  void closeLogoutStreamController() {
    $logoutController?.close();
  }

  @override
  StreamController<bool>? $inactividadController;

  @override
  void closeInactividadStreamController() {
    $inactividadController?.close();
  }

  @override
  void initializeTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(AppConstants.DURACION_INACTIVIDAD, () {
      $inactividadController!.add(true);
    });
  }

  @override
  bool? primeraConsultaVectorExterno;
}
