import 'dart:async';
import 'dart:developer';

import 'package:app_mercury_flutter/core/index.dart';
import 'package:app_mercury_flutter/domain/entities/index.dart';
import 'package:app_mercury_flutter/entrypoint/application/config/app_strings.dart';
import 'package:rxdart/rxdart.dart';
import 'package:app_mercury_flutter/entrypoint/blocs/provider/index.dart'
    show Bloc;
import 'package:app_mercury_flutter/entrypoint/ui/screens/index.dart'
    show CategoriesTextFielTypeEnum;
import 'package:app_mercury_flutter/entrypoint/ui/shared/index.dart'
    show FieldStream, RequiredValidator, ValidateAllStreamsHaveDataAndNoErrors;
// Use cases
import 'package:app_mercury_flutter/domain/use_cases/index.dart'
    show AddCategoryUseCase, GetCategoriesUseCase;

class CategoryBloc with Bloc {
  final AddCategoryUseCase _addCategoryUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  late Map<CategoriesTextFielTypeEnum, FieldStream> $streams;
  late List<StreamSubscription> subscriptions;

  final BehaviorSubject<bool> _loadingCategory =
      BehaviorSubject<bool>.seeded(false);
  ValueStream<bool> get $loadingCategory => _loadingCategory.stream;

  ValidateAllStreamsHaveDataAndNoErrors? _validateAllStreamsHaveDataAndNoErrors;
  Stream<bool>? get $formularioValido =>
      _validateAllStreamsHaveDataAndNoErrors?.status;
  BehaviorSubject<List<Category>> _categoriesController =
      BehaviorSubject<List<Category>>();
  ValueStream<List<Category>> get $categories => _categoriesController.stream;

  CategoryBloc(this._addCategoryUseCase, this._getCategoriesUseCase) {
    _categoriesController = BehaviorSubject<List<Category>>();
    subscriptions = [];
  }

  @override
  void init() {
    _loadStreams();
    _loadValidators();
    _listenValidateAllStreamsHaveDataAndNoErrors();
    _getCategories();
  }

  @override
  void dispose() {
    _disposeValidateAllStreamsHaveDataAndNoErrors();
    _cancelSuscriptions();
    _disposeStreams();
    _closeLoadingCategory();
    _closeCategories();
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

  void _closeCategories() {
    _categoriesController.close();
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

  Future<ResultadoUI<Category>> addCategory() async {
    _showLoadingCategory();
    ResultadoUI<Category> resultadoUI;
    resultadoUI = await _addCategory();
    _hideLoadingCategory();
    return resultadoUI;
  }

  Future<ResultadoUI<Category>> _addCategory() async {
    try {
      Category params = await _getCategory();
      final respuesta = await _addCategoryUseCase(params);

      return ResultadoUI.success(respuesta);
    } catch (ex) {
      log(ex.toString(), name: '_addCategory');
      if (ex is CustomErrorResult) {
        return ResultadoUI.error(message: ex.message);
      }

      return ResultadoUI.error(message: AppStrings.errorGeneral);
    }
  }

  Future<Category> _getCategory() async {
    Category params = Category();
    params.name =
        $streams[CategoriesTextFielTypeEnum.name]!.fieldController.value;
    params.description =
        $streams[CategoriesTextFielTypeEnum.description]!.fieldController.value;
    return params;
  }

  Future<void> getCategories() async {
    _showLoadingCategory();
    await _getCategories();
    _hideLoadingCategory();
  }

  Future<void> _getCategories() async {
    try {
      final respuesta = await _getCategoriesUseCase();
      verifySinkAddStream(_categoriesController, () {
        _categoriesController.value = respuesta;
      });
    } catch (ex) {
      log(ex.toString(), name: '_getCategories');
      if (ex is CustomErrorResult) {}
    }
  }
}
