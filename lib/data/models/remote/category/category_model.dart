import 'dart:convert';

class CategoryModel {
  CategoryModel({
    this.id,
    this.nombre,
    this.descripcion,
  });

  int? id;
  String? nombre;
  String? descripcion;

  CategoryModel.completo(
    this.id,
    this.nombre,
    this.descripcion,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));
}
