class User {
  User({
    this.id,
    this.fullName,
    this.lastName,
    this.birthDate,
  });

  String? id;
  String? fullName;
  String? lastName;
  String? birthDate;

  User.complete(this.id, this.fullName, this.lastName, this.birthDate);
}
