import 'package:app_mercury_flutter/domain/repositories/index.dart'
    show DeleteUserRepository;

class DeleteUserUseCase {
  DeleteUserUseCase(this._deleteUserRepository);
  final DeleteUserRepository _deleteUserRepository;

  Future<void> call(String id) async {
    return await _deleteUserRepository.deleteUser(id);
  }
}
