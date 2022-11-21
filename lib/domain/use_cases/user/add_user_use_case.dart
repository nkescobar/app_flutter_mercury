import 'package:app_mercury_flutter/domain/entities/index.dart' show User;
import 'package:app_mercury_flutter/domain/repositories/index.dart'
    show AddUserRepository;

class AddUserUseCase {
  AddUserUseCase(this._addUserRepository);

  final AddUserRepository _addUserRepository;

  Future<void> call(User user) async {
    return await _addUserRepository.addUser(user);
  }
}
