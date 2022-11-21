import 'dart:async';
import 'dart:developer';
import 'package:rxdart/rxdart.dart';
import 'package:app_mercury_flutter/core/index.dart' show CustomErrorResult;

import 'package:app_mercury_flutter/entrypoint/ui/screens/users/index.dart'
    show UserTextFielTypeEnum;
import 'package:app_mercury_flutter/domain/entities/index.dart' show User;
import 'package:app_mercury_flutter/entrypoint/blocs/provider/index.dart'
    show Bloc;

import 'package:app_mercury_flutter/entrypoint/ui/shared/index.dart'
    show FieldStream, RequiredValidator, ValidateAllStreamsHaveDataAndNoErrors;
// Use cases
import 'package:app_mercury_flutter/domain/use_cases/index.dart'
    show AddUserUseCase, GetUsersUseCase;

class UserBloc with Bloc {
  final AddUserUseCase _addUserUseCase;
  final GetUsersUseCase _getUsersUseCase;

  late Map<UserTextFielTypeEnum, FieldStream> $streams;
  late List<StreamSubscription> subscriptions;

  final BehaviorSubject<bool> _loadingUser =
      BehaviorSubject<bool>.seeded(false);
  ValueStream<bool> get $loadingCategory => _loadingUser.stream;

  ValidateAllStreamsHaveDataAndNoErrors? _validateAllStreamsHaveDataAndNoErrors;
  Stream<bool>? get $formularioValido =>
      _validateAllStreamsHaveDataAndNoErrors?.status;
  BehaviorSubject<List<User>> _usersController = BehaviorSubject<List<User>>();
  ValueStream<List<User>> get $users => _usersController.stream;

  UserBloc(this._addUserUseCase, this._getUsersUseCase) {
    _usersController = BehaviorSubject<List<User>>();
    subscriptions = [];
  }

  @override
  void init() {
    _loadStreams();
    _loadValidators();
    _listenValidateAllStreamsHaveDataAndNoErrors();
    getUsers();
  }

  @override
  void dispose() {
    _disposeValidateAllStreamsHaveDataAndNoErrors();
    _cancelSuscriptions();
    _disposeStreams();
    _closeLoadingCategory();
    _closeUsers();
  }

  void _loadStreams() {
    $streams = {};
    $streams[UserTextFielTypeEnum.id] = FieldStream<String>([
      RequiredValidator<String>(),
    ]);
    $streams[UserTextFielTypeEnum.fullName] = FieldStream<String>([
      RequiredValidator<String>(),
    ]);
    $streams[UserTextFielTypeEnum.lastName] = FieldStream<String>([
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
    _loadingUser.close();
  }

  void _closeUsers() {
    _usersController.close();
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

  void _hideLoadingUser() {
    verifySinkAddStream(_loadingUser, () {
      _loadingUser.value = false;
    });
  }

  void _showLoadingUser() {
    verifySinkAddStream(_loadingUser, () {
      _loadingUser.value = true;
    });
  }

  Future<void> addUser() async {
    _showLoadingUser();
    await _addUser();
    _hideLoadingUser();
  }

  Future<void> _addUser() async {
    try {
      User params = await _getUser();
      await _addUserUseCase(params);
    } catch (ex) {
      log(ex.toString(), name: '_addUser');
    }
  }

  Future<User> _getUser() async {
    User params = User();
    params.id = $streams[UserTextFielTypeEnum.id]!.fieldController.value;
    params.fullName =
        $streams[UserTextFielTypeEnum.fullName]!.fieldController.value;
    params.lastName =
        $streams[UserTextFielTypeEnum.lastName]!.fieldController.value;
    return params;
  }

  Future<void> getUsers() async {
    _showLoadingUser();
    await _getUsers();
    _hideLoadingUser();
  }

  Future<void> _getUsers() async {
    try {
      final respuesta = await _getUsersUseCase();
      verifySinkAddStream(_usersController, () {
        _usersController.value = respuesta;
      });
    } catch (ex) {
      log(ex.toString(), name: '_getUsers');
      if (ex is CustomErrorResult) {}
    }
  }
}
