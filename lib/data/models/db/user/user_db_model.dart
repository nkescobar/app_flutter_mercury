import 'dart:convert';

class UserDBModel {
  UserDBModel({
    this.id,
    this.fullName,
    this.lastName,
    this.birthDate,
  });

  String? id;
  String? fullName;
  String? lastName;
  String? birthDate;

  UserDBModel.completo(
    this.id,
    this.fullName,
    this.lastName,
    this.birthDate,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'lastName': lastName,
      'birthDate': birthDate,
    };
  }

  factory UserDBModel.fromMap(Map<String, dynamic> map) {
    return UserDBModel(
      id: map['id'],
      fullName: map['fullName'],
      lastName: map['lastName'],
      birthDate: map['birthDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDBModel.fromJson(String source) =>
      UserDBModel.fromMap(json.decode(source));
}
