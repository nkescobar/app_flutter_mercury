import 'package:app_mercury_flutter/domain/entities/index.dart' show Category;
import 'package:app_mercury_flutter/domain/repositories/index.dart'
    show AddCategoryRepository;

class AddCategoryUseCase {
  AddCategoryUseCase(this._addCategoryRepository);

  final AddCategoryRepository _addCategoryRepository;

  Future<Category> call(Category category) async {
    return await _addCategoryRepository.addCategory(category);
  }
}
