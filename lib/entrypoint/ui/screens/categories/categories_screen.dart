import 'package:flutter/material.dart';
// Configurations
import 'package:app_mercury_flutter/entrypoint/application/config/index.dart'
    show AppStyles;
import 'package:app_mercury_flutter/entrypoint/di/injector.dart';
// Widgets shared
import 'package:app_mercury_flutter/entrypoint/ui/shared/index.dart'
    show BaseStateBloc, ButtonStreamLoadingWidget, ButtonTypeEnum;

import 'package:app_mercury_flutter/domain/entities/index.dart' show Category;
import 'package:app_mercury_flutter/core/index.dart'
    show ResultadoUI, StatusEnum;
// BLoc
import 'package:app_mercury_flutter/entrypoint/blocs/categories/index.dart'
    show CategoryBloc;
import 'package:app_mercury_flutter/entrypoint/ui/screens/categories/widgets/index.dart'
    show CategoryFormWidget;

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
    return CategoryBloc(Injector().provideAddCategoryUseCase());
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
                    children: [
                      const CategoryFormWidget(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppStyles.paddingL,
                        ),
                        child: StreamBuilder<bool>(
                            stream: bloc!.$formularioValido,
                            builder: (context, snapshot) {
                              return ButtonStreamLoadingWidget(
                                text: 'Agregar categoria',
                                isLoading: bloc!.$loadingCategory,
                                buttonTypeEnum:
                                    ButtonTypeEnum.buttonActionMainPositive,
                                onPressed:
                                    (snapshot.hasData && snapshot.data == true)
                                        ? () => _addCategory(context)
                                        : bloc!.validateFormAndShowErrors,
                              );
                            }),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addCategory(BuildContext context) async {
    fieldFocusChange(context, null, null);
    ResultadoUI<Category> resultadoUI = await bloc!.addCategory();
    if (resultadoUI.status != null &&
        resultadoUI.status
                .toString()
                .compareTo(StatusEnum.success.toString()) ==
            0) {
      print('TODO MELO');
    } else {
      print('Hubo un error ');
    }
  }
}
