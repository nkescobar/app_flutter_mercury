import 'package:flutter/material.dart';

import 'package:app_mercury_flutter/domain/entities/index.dart' show User;

class UserListWidget extends StatelessWidget {
  final Stream<List<User>> users;
  const UserListWidget({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<User>>(
        stream: users,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty == true) {
            var users = snapshot.data!;
            users.sort((a, b) => a.fullName!.compareTo(b.fullName!));
            return SizedBox(
              height: 400,
              child: ListView.separated(
                addAutomaticKeepAlives: true,
                primary: false,
                itemCount: users.length,
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.red),
                itemBuilder: (BuildContext context, int index) {
                  final user = users[index];
                  return ListTile(
                    title: Text('${user.fullName} ${user.lastName}'),
                    subtitle: Text(user.id ?? ''),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('No se encuentran registros'));
          }
        });
  }
}
