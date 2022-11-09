import 'package:app_mercury_flutter/domain/entities/index.dart' show Category;

abstract class AddCategoryRepository {
  Future<Category> addCategory(Category category);
}
