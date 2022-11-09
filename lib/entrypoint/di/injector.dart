import 'package:app_mercury_flutter/domain/index.dart';
import 'package:app_mercury_flutter/entrypoint/di/repository_injector.dart';

class Injector {
  static Injector? _singleton;

  factory Injector() {
    _singleton ??= Injector._();
    return _singleton!;
  }

  Injector._();

  AddCategoryUseCase provideAddCategoryUseCase() {
    return AddCategoryUseCase(
        RepositoryInjector().provideAddCategoryRepository());
  }
}
