import 'package:app_mercury_flutter/data/repositories/index.dart'
    show AddCategoryRepositoryAdapter;
import 'package:app_mercury_flutter/domain/index.dart'
    show AddCategoryRepository;
import 'package:app_mercury_flutter/entrypoint/di/data_source_injector.dart';

class RepositoryInjector {
  static RepositoryInjector? _singleton;

  factory RepositoryInjector() {
    _singleton ??= RepositoryInjector._();
    return _singleton!;
  }

  RepositoryInjector._();

  AddCategoryRepository provideAddCategoryRepository() {
    return AddCategoryRepositoryAdapter(
      DataSourceInjector().provideAddCategoryApiSource(),
    );
  }
}
