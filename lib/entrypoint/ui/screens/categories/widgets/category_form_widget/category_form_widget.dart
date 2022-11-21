import 'package:app_mercury_flutter/entrypoint/di/injector.dart';
import 'package:flutter/material.dart';

import 'package:app_mercury_flutter/entrypoint/application/config/index.dart'
    show AppColors;

import 'package:app_mercury_flutter/entrypoint/ui/shared/widgets/index.dart'
    show BaseFormStateBloc, IconButtonGenericWidget, TextFieldStreamWidget;
import 'package:app_mercury_flutter/entrypoint/ui/screens/index.dart'
    show CategoriesTextFielTypeEnum;
import 'package:app_mercury_flutter/entrypoint/blocs/categories/index.dart'
    show CategoryBloc;

class CategoryFormWidget extends StatefulWidget {
  const CategoryFormWidget({Key? key}) : super(key: key);

  @override
  State<CategoryFormWidget> createState() => _CategoryFormWidgetState();
}

class _CategoryFormWidgetState extends BaseFormStateBloc<CategoryFormWidget,
    CategoriesTextFielTypeEnum, CategoryBloc> {
  _CategoryFormWidgetState() : super(CategoriesTextFielTypeEnum.values);

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
    return CategoryBloc(
      Injector().provideAddCategoryUseCase(),
      Injector().provideGetCategoriesUseCase(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: bloc!.$loadingCategory,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == false) {
            _restartFields();
          }
          return Column(
            children: [
              TextFieldStreamWidget(
                stream: bloc!.$streams[CategoriesTextFielTypeEnum.name]!
                    .$streamField as Stream<String>,
                hintText: 'Nombre categoria',
                textCapitalization: TextCapitalization.words,
                controller:
                    textEditingControllers[CategoriesTextFielTypeEnum.name],
                focusNode: focusNodes[CategoriesTextFielTypeEnum.name],
                onSubmitted: (valor) {
                  fieldFocusChange(
                    context,
                    focusNodes[CategoriesTextFielTypeEnum.name],
                    focusNodes[CategoriesTextFielTypeEnum.description],
                  );
                  bloc!.$streams[CategoriesTextFielTypeEnum.name]!
                      .onChangeField(valor);
                },
                onChanged: (valor) => bloc!
                    .$streams[CategoriesTextFielTypeEnum.name]!
                    .onChangeField(valor),
                prefixIcon: Icon(
                  Icons.account_balance_wallet,
                  color: AppColors.secondaryColor.shade500,
                ),
                suffixIcon: IconButtonGenericWidget(
                  icon: Icons.clear,
                  onPressed: () {
                    textEditingControllers[CategoriesTextFielTypeEnum.name]!
                        .clear();
                    bloc!.$streams[CategoriesTextFielTypeEnum.name]!
                        .onChangeField('');
                  },
                ),
              ),
              TextFieldStreamWidget(
                stream: bloc!.$streams[CategoriesTextFielTypeEnum.description]!
                    .$streamField as Stream<String>,
                hintText: 'Descripcion',
                textCapitalization: TextCapitalization.none,
                controller: textEditingControllers[
                    CategoriesTextFielTypeEnum.description],
                focusNode: focusNodes[CategoriesTextFielTypeEnum.description],
                onSubmitted: (valor) {
                  fieldFocusChange(
                    context,
                    focusNodes[null],
                    focusNodes[null],
                  );
                  bloc!.$streams[CategoriesTextFielTypeEnum.description]!
                      .onChangeField(valor);
                },
                onChanged: (valor) => bloc!
                    .$streams[CategoriesTextFielTypeEnum.description]!
                    .onChangeField(valor),
                prefixIcon: Icon(
                  Icons.note,
                  color: AppColors.secondaryColor.shade500,
                ),
                suffixIcon: IconButtonGenericWidget(
                  icon: Icons.clear,
                  onPressed: () {
                    textEditingControllers[
                            CategoriesTextFielTypeEnum.description]!
                        .clear();
                    bloc!.$streams[CategoriesTextFielTypeEnum.description]!
                        .onChangeField('');
                  },
                ),
              ),
            ],
          );
        });
  }

  _restartFields() {
    textEditingControllers[CategoriesTextFielTypeEnum.name]!.clear();
    textEditingControllers[CategoriesTextFielTypeEnum.description]!.clear();
  }
}
