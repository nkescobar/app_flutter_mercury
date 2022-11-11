import 'package:app_mercury_flutter/data/models/index.dart' show CategoryModel;
import 'package:app_mercury_flutter/domain/entities/index.dart' show Category;

class CategoryMapper {
  static Category fromEntity(CategoryModel categoryRemoteModel) {
    Category category = Category(
      id: categoryRemoteModel.id,
      name: categoryRemoteModel.nombre ?? '',
      description: categoryRemoteModel.descripcion ?? '',
    );
    return category;
  }

  static CategoryModel fromModel(Category category) {
    CategoryModel categoryRemoteModel = CategoryModel();
    categoryRemoteModel.id = category.id;
    categoryRemoteModel.nombre = category.name;
    categoryRemoteModel.descripcion = category.description;
    return categoryRemoteModel;
  }

  static List<Category> fromEntityList(List<CategoryModel> categoriesModel) {
    List<Category> categories = [];
    for (var item in categoriesModel) {
      categories.add(fromEntity(item));
    }
    return categories;
  }

  static List<CategoryModel> fromModelList(List<Category> categories) {
    List<CategoryModel> categoriesModel = [];
    for (var item in categories) {
      categoriesModel.add(fromModel(item));
    }
    return categoriesModel;
  }
}
