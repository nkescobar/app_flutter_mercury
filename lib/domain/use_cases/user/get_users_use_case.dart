import 'package:app_mercury_flutter/domain/entities/index.dart' show User;
import 'package:app_mercury_flutter/domain/repositories/index.dart'
    show GetUsersRepository;

class GetUsersUseCase {
  GetUsersUseCase(this._getUsersRepository);

  final GetUsersRepository _getUsersRepository;

  Future<List<User>> call() async {
    return await _getUsersRepository.getUsers();
  }
}
