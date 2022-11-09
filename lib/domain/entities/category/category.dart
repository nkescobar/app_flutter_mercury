class Category {
  Category({
    this.id,
    this.name,
    this.description,
  });

  int? id;
  String? name;
  String? description;

  Category.completo(
    this.id,
    this.name,
    this.description,
  );
}
