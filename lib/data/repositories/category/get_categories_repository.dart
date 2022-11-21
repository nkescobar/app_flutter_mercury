import 'package:app_mercury_flutter/core/index.dart'
    show CustomErrorResult, Resultado, StatusEnum;
import 'package:app_mercury_flutter/data/api_sources/index.dart'
    show GetCategoriesApiSource;
import 'package:app_mercury_flutter/data/mappers/index.dart'
    show CategoryMapper;
import 'package:app_mercury_flutter/data/utils/index.dart'
    show ValidateStatusEnum;
import 'package:app_mercury_flutter/domain/entities/index.dart' show Category;
import 'package:app_mercury_flutter/domain/index.dart'
    show GetCategoriesRepository;

class GetCategoriesRepositoryAdapter implements GetCategoriesRepository {
  final GetCategoriesApiSource apiSource;

  GetCategoriesRepositoryAdapter(this.apiSource);

  @override
  Future<List<Category>> getCategories() async {
    Resultado resultadoApi = await apiSource.getCategories();

    if (ValidateStatusEnum.validateStatus(
            resultadoApi.status.toString(), StatusEnum.error.toString()) ==
        true) {
      throw (CustomErrorResult(
          code: resultadoApi.error?.code,
          message: resultadoApi.error?.message));
    }
    List<Category> respuesta = CategoryMapper.fromEntityList(resultadoApi.data);
    return respuesta;
  }
}
