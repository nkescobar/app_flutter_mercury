import 'package:app_mercury_flutter/domain/entities/index.dart' show Category;
import 'package:app_mercury_flutter/domain/repositories/index.dart'
    show GetCategoriesRepository;

class GetCategoriesUseCase {
  GetCategoriesUseCase(this._getCategoriesRepository);

  final GetCategoriesRepository _getCategoriesRepository;

  Future<List<Category>> call() async {
    return await _getCategoriesRepository.getCategories();
  }
}
