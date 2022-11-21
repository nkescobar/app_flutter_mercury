import 'package:app_mercury_flutter/domain/index.dart'
    show
        AddCategoryUseCase,
        AddUserUseCase,
        GetCategoriesUseCase,
        GetUsersUseCase;
import 'package:app_mercury_flutter/entrypoint/di/repository_injector.dart';

class Injector {
  static Injector? _singleton;

  factory Injector() {
    _singleton ??= Injector._();
    return _singleton!;
  }

  Injector._();

  AddUserUseCase provideAddUserUseCase() {
    return AddUserUseCase(RepositoryInjector().provideAddUserRepository());
  }

  GetUsersUseCase provideGetUsersUseCase() {
    return GetUsersUseCase(RepositoryInjector().provideGetUsersRepository());
  }

  AddCategoryUseCase provideAddCategoryUseCase() {
    return AddCategoryUseCase(
        RepositoryInjector().provideAddCategoryRepository());
  }

  GetCategoriesUseCase provideGetCategoriesUseCase() {
    return GetCategoriesUseCase(
        RepositoryInjector().provideGetCategoriesRepository());
  }
}
