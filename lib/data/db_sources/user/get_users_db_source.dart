import 'package:app_mercury_flutter/data/models/index.dart' show UserDBModel;

mixin GetUsersDBSource {
  Future<List<UserDBModel>> getUsers();
}
