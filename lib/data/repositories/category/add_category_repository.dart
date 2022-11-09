import 'package:app_mercury_flutter/core/index.dart'
    show CustomErrorResult, Resultado, StatusEnum;
import 'package:app_mercury_flutter/data/api_sources/index.dart'
    show AddCategoryApiSource;
import 'package:app_mercury_flutter/data/mappers/index.dart'
    show CategoryMapper;
import 'package:app_mercury_flutter/data/utils/index.dart'
    show ValidateStatusEnum;
import 'package:app_mercury_flutter/domain/entities/index.dart' show Category;
import 'package:app_mercury_flutter/domain/index.dart'
    show AddCategoryRepository;

class AddCategoryRepositoryAdapter implements AddCategoryRepository {
  final AddCategoryApiSource apiSource;

  AddCategoryRepositoryAdapter(this.apiSource);

  @override
  Future<Category> addCategory(Category category) async {
    Resultado resultadoApi =
        await apiSource.addCategory(CategoryMapper.fromModel(category));

    if (ValidateStatusEnum.validateStatus(
            resultadoApi.status.toString(), StatusEnum.error.toString()) ==
        true) {
      throw (CustomErrorResult(
          code: resultadoApi.error?.code,
          message: resultadoApi.error?.message));
    }
    Category respuesta = CategoryMapper.fromEntity(resultadoApi.data);
    return respuesta;
  }
}
