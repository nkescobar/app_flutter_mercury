import 'package:app_mercury_flutter/data/models/db/index.dart' show UserDBModel;
import 'package:app_mercury_flutter/domain/entities/index.dart' show User;

class UserMapper {
  static User fromEntity(UserDBModel userDBModel) {
    User user = User(
      id: userDBModel.id,
      fullName: userDBModel.fullName ?? '',
      lastName: userDBModel.lastName ?? '',
      birthDate: userDBModel.birthDate ?? '',
    );
    return user;
  }

  static UserDBModel fromModel(User user) {
    UserDBModel userDBModel = UserDBModel();
    userDBModel.id = user.id;
    userDBModel.lastName = user.lastName;
    userDBModel.fullName = user.fullName;
    userDBModel.birthDate = user.birthDate;

    return userDBModel;
  }

  static List<User> fromEntityList(List<UserDBModel> usersModel) {
    List<User> users = [];
    for (var item in usersModel) {
      users.add(fromEntity(item));
    }
    return users;
  }

  static List<UserDBModel> fromModelList(List<User> users) {
    List<UserDBModel> usersModel = [];
    for (var item in users) {
      usersModel.add(fromModel(item));
    }
    return usersModel;
  }
}
