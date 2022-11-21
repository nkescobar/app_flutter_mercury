import 'package:app_mercury_flutter/data/models/index.dart' show UserDBModel;

mixin UpdateUserDBSource {
  Future<void> updateUser(UserDBModel userDBModel);
}
