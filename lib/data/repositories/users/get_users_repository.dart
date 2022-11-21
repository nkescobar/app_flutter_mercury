import 'package:app_mercury_flutter/data/db_sources/index.dart'
    show GetUsersDBSource;
import 'package:app_mercury_flutter/data/mappers/index.dart' show UserMapper;
import 'package:app_mercury_flutter/data/models/index.dart' show UserDBModel;

import 'package:app_mercury_flutter/domain/index.dart'
    show GetUsersRepository, User;

class GetUsersRepositoryAdapter implements GetUsersRepository {
  final GetUsersDBSource dbSource;

  GetUsersRepositoryAdapter(this.dbSource);

  @override
  Future<List<User>> getUsers() async {
    List<UserDBModel> result = await dbSource.getUsers();
    List<User> response = UserMapper.fromEntityList(result);
    return response;
  }
}
