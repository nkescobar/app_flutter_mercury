import 'package:app_mercury_flutter/domain/entities/index.dart' show User;
import 'package:app_mercury_flutter/domain/repositories/index.dart'
    show UpdateUserRepository;

class UpdateUserUseCase {
  UpdateUserUseCase(this._updateUserRepository);

  final UpdateUserRepository _updateUserRepository;

  Future<User> call(User user) async {
    return await _updateUserRepository.updateUser(user);
  }
}
