import 'package:http/http.dart' as http;
import 'package:app_mercury_flutter/data/models/index.dart' show CategoryModel;

import 'package:app_mercury_flutter/core/index.dart'
    show MyConnectivity, MySingletonSharedPreferences, Resultado;

import 'package:app_mercury_flutter/data/api_sources/index.dart'
    show GetCategoriesApiSource;
import 'package:app_mercury_flutter/entrypoint/data_source/api/base/index.dart'
    show ApiSource;
import 'package:app_mercury_flutter/entrypoint/data_source/api/base/enums/index.dart'
    show TypeResponseEnum;

class GetCategoriesApiSourceAdapter extends ApiSource
    implements GetCategoriesApiSource {
  GetCategoriesApiSourceAdapter(
    String? baseUrl,
    http.Client client,
    MyConnectivity connectivity,
    MySingletonSharedPreferences sharedPreferences,
  ) : super(baseUrl, client, connectivity, sharedPreferences);

  @override
  Future<Resultado<List<CategoryModel>>> getCategories() async {
    var url = '${baseUrl}categorias';
    return await getApi(url, (value) {
      return List<CategoryModel>.from(
          value.map((x) => CategoryModel.fromMap(x)));
    }, typeResponse: TypeResponseEnum.dataInResponse);
  }
}
