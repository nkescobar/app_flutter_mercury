import 'package:app_mercury_flutter/domain/entities/index.dart' show User;

abstract class AddUserRepository {
  Future<void> addUser(User user);
}
