import 'package:app_mercury_flutter/domain/entities/index.dart' show User;

abstract class UpdateUserRepository {
  Future<User> updateUser(User category);
}
