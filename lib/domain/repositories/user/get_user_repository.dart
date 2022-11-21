import 'package:app_mercury_flutter/domain/entities/index.dart' show User;

abstract class GetUsersRepository {
  Future<List<User>> getUsers();
}
