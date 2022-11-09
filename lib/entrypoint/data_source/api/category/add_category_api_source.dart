import 'package:http/http.dart' as http;
import 'package:app_mercury_flutter/data/models/index.dart' show CategoryModel;

import 'package:app_mercury_flutter/core/index.dart'
    show MyConnectivity, MySingletonSharedPreferences, Resultado;

import 'package:app_mercury_flutter/data/api_sources/index.dart'
    show AddCategoryApiSource;
import 'package:app_mercury_flutter/entrypoint/data_source/api/base/index.dart'
    show ApiSource;
import 'package:app_mercury_flutter/entrypoint/data_source/api/base/enums/index.dart'
    show TypeResponseEnum;

class AddCategoryApiSourceAdapter extends ApiSource
    implements AddCategoryApiSource {
  AddCategoryApiSourceAdapter(
    String? baseUrl,
    http.Client client,
    MyConnectivity connectivity,
    MySingletonSharedPreferences sharedPreferences,
  ) : super(baseUrl, client, connectivity, sharedPreferences);

  @override
  Future<Resultado<CategoryModel>> addCategory(CategoryModel params) async {
    var url = '${baseUrl}categorias';
    return await postApi(url, params.toMap(), (value) {
      return CategoryModel.fromMap(value);
    }, typeResponse: TypeResponseEnum.dataInResponse);
  }
}
