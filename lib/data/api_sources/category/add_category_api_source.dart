import 'package:app_mercury_flutter/core/index.dart' show Resultado;
import 'package:app_mercury_flutter/data/models/index.dart' show CategoryModel;

mixin AddCategoryApiSource {
  Future<Resultado<CategoryModel>> addCategory(CategoryModel categoryModel);
}
