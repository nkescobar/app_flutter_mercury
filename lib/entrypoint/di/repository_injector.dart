import 'package:app_mercury_flutter/data/repositories/index.dart'
    show
        AddCategoryRepositoryAdapter,
        AddUserRepositoryAdapter,
        GetCategoriesRepositoryAdapter,
        GetUsersRepositoryAdapter;
import 'package:app_mercury_flutter/domain/index.dart'
    show
        AddCategoryRepository,
        AddUserRepository,
        GetCategoriesRepository,
        GetUsersRepository;
import 'package:app_mercury_flutter/entrypoint/di/data_source_injector.dart';

class RepositoryInjector {
  static RepositoryInjector? _singleton;

  factory RepositoryInjector() {
    _singleton ??= RepositoryInjector._();
    return _singleton!;
  }

  RepositoryInjector._();

  AddUserRepository provideAddUserRepository() {
    return AddUserRepositoryAdapter(
      DataSourceInjector().provideAddUserDBSource(),
    );
  }

  GetUsersRepository provideGetUsersRepository() {
    return GetUsersRepositoryAdapter(
      DataSourceInjector().provideGetUsersDBSource(),
    );
  }

  AddCategoryRepository provideAddCategoryRepository() {
    return AddCategoryRepositoryAdapter(
      DataSourceInjector().provideAddCategoryApiSource(),
    );
  }

  GetCategoriesRepository provideGetCategoriesRepository() {
    return GetCategoriesRepositoryAdapter(
      DataSourceInjector().provideGetCategoriesApiSource(),
    );
  }
}
