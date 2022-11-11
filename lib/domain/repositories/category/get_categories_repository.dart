import 'package:app_mercury_flutter/domain/entities/index.dart' show Category;

abstract class GetCategoriesRepository {
  Future<List<Category>> getCategories();
}
