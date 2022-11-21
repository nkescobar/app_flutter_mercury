import 'package:flutter/material.dart';

import 'package:app_mercury_flutter/domain/entities/index.dart' show Category;

class CategoryListWidget extends StatelessWidget {
  final Stream<List<Category>> categories;
  const CategoryListWidget({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
        stream: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty == true) {
            var categories = snapshot.data!;
            categories.sort((a, b) => b.id!.compareTo(a.id!));
            return SizedBox(
              height: 400,
              child: ListView.separated(
                addAutomaticKeepAlives: true,
                primary: false,
                itemCount: categories.length,
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.red),
                itemBuilder: (BuildContext context, int index) {
                  final category = categories[index];
                  return ListTile(
                    title: Text(category.name ?? ''),
                    subtitle: Text(category.description ?? ''),
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
