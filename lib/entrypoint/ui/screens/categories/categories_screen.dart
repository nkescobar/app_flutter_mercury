import 'package:app_mercury_flutter/entrypoint/application/config/app_styles.dart';
import 'package:flutter/material.dart';

import 'package:app_mercury_flutter/entrypoint/ui/shared/widgets/index.dart';
import 'package:app_mercury_flutter/entrypoint/blocs/categories/index.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState
    extends BaseStateBloc<CategoriesScreen, CategoryBloc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  CategoryBloc getBlocInstance() {
    return CategoryBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppStyles.paddingXL,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Categoria',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
