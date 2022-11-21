import 'package:app_mercury_flutter/data/db_sources/index.dart'
    show AddUserDBSource;
import 'package:app_mercury_flutter/data/mappers/index.dart' show UserMapper;

import 'package:app_mercury_flutter/domain/index.dart'
    show User, AddUserRepository;

class AddUserRepositoryAdapter implements AddUserRepository {
  final AddUserDBSource dbSource;

  AddUserRepositoryAdapter(this.dbSource);

  @override
  Future<void> addUser(User user) async {
    await dbSource.addUser(UserMapper.fromModel(user));
  }
}
