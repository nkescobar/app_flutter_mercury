import 'package:http/http.dart' as http;

import 'package:app_mercury_flutter/entrypoint/data_source/api/category/index.dart'
    show AddCategoryApiSourceAdapter, GetCategoriesApiSourceAdapter;
import 'package:app_mercury_flutter/core/utils/index.dart'
    show MyConnectivityImpl, MySingletonSharedPreferencesImpl;

import 'package:app_mercury_flutter/data/api_sources/index.dart'
    show AddCategoryApiSource, GetCategoriesApiSource;
import 'package:app_mercury_flutter/entrypoint/application/config/index.dart'
    show Application;

class DataSourceInjector {
  static DataSourceInjector? _singleton;
  factory DataSourceInjector() {
    _singleton ??= DataSourceInjector._();
    return _singleton!;
  }

  DataSourceInjector._();

  AddCategoryApiSource provideAddCategoryApiSource() {
    return AddCategoryApiSourceAdapter(
      Application().appSettings?.baseUrl,
      http.Client(),
      MyConnectivityImpl(),
      MySingletonSharedPreferencesImpl(),
    );
  }

  GetCategoriesApiSource provideGetCategoriesApiSource() {
    return GetCategoriesApiSourceAdapter(
      Application().appSettings?.baseUrl,
      http.Client(),
      MyConnectivityImpl(),
      MySingletonSharedPreferencesImpl(),
    );
  }
}
