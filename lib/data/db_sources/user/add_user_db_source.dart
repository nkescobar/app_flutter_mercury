import 'package:app_mercury_flutter/data/models/index.dart' show UserDBModel;

mixin AddUserDBSource {
  Future<void> addUser(UserDBModel userDBModel);
}
