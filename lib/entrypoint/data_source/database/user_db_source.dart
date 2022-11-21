import 'dart:async';

import 'package:sembast/sembast.dart';
import 'config/app_database.dart';
import 'package:app_mercury_flutter/data/db_sources/index.dart'
    show
        AddUserDBSource,
        DeleteUserDBSource,
        DeleteUsersDBSource,
        GetUsersDBSource,
        UpdateUserDBSource;
import 'package:app_mercury_flutter/data/models/db/user/user_db_model.dart';

class UserDBSourceImpl
    implements
        AddUserDBSource,
        GetUsersDBSource,
        UpdateUserDBSource,
        DeleteUsersDBSource,
        DeleteUserDBSource {
  Future<Database> get _db async => await AppDatabase().database;
  static const String folderName = "users";
  final _usersFolder = intMapStoreFactory.store(folderName);

  @override
  Future<List<UserDBModel>> getUsers() async {
    final recordSnapshot = await _usersFolder.find(await _db);
    return recordSnapshot.map((snapshot) {
      final users = UserDBModel.fromMap(snapshot.value);
      return users;
    }).toList();
  }

  @override
  Future<void> addUser(UserDBModel userDBModel) async {
    await _usersFolder.add(await _db, userDBModel.toMap());
  }

  @override
  Future<void> deleteUsers() async {
    var store = StoreRef.main();
    await store.record('user').delete(await _db);
  }

  @override
  Future<void> deleteUser(String id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await _usersFolder.delete(await _db, finder: finder);
  }

  @override
  Future<void> updateUser(UserDBModel userDBModel) async {
    final finder = Finder(filter: Filter.byKey(userDBModel.id));
    await _usersFolder.update(await _db, userDBModel.toMap(), finder: finder);
  }
}
