import 'package:app_mercury_flutter/entrypoint/ui/screens/users/i18n/user.i18n.dart';
import 'package:flutter/material.dart';

import 'package:app_mercury_flutter/entrypoint/ui/screens/users/enums/user_textfield_type_enum.dart';
import 'package:app_mercury_flutter/entrypoint/di/injector.dart';
import 'package:app_mercury_flutter/entrypoint/application/config/index.dart'
    show AppColors;

import 'package:app_mercury_flutter/entrypoint/ui/shared/widgets/index.dart'
    show BaseFormStateBloc, IconButtonGenericWidget, TextFieldStreamWidget;

import 'package:app_mercury_flutter/entrypoint/blocs/users/index.dart'
    show UserBloc;

class UserFormWidget extends StatefulWidget {
  const UserFormWidget({Key? key}) : super(key: key);

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState
    extends BaseFormStateBloc<UserFormWidget, UserTextFielTypeEnum, UserBloc> {
  _UserFormWidgetState() : super(UserTextFielTypeEnum.values);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  UserBloc getBlocInstance() {
    return UserBloc(
      Injector().provideAddUserUseCase(),
      Injector().provideGetUsersUseCase(),
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
                stream: bloc!.$streams[UserTextFielTypeEnum.id]!.$streamField
                    as Stream<String>,
                hintText: UserStrings.labelTextFieldId.i18n,
                textCapitalization: TextCapitalization.words,
                controller: textEditingControllers[UserTextFielTypeEnum.id],
                focusNode: focusNodes[UserTextFielTypeEnum.id],
                onSubmitted: (valor) {
                  fieldFocusChange(
                    context,
                    focusNodes[UserTextFielTypeEnum.id],
                    focusNodes[UserTextFielTypeEnum.fullName],
                  );
                  bloc!.$streams[UserTextFielTypeEnum.id]!.onChangeField(valor);
                },
                onChanged: (valor) => bloc!.$streams[UserTextFielTypeEnum.id]!
                    .onChangeField(valor),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: AppColors.secondaryColor.shade500,
                ),
                suffixIcon: IconButtonGenericWidget(
                  icon: Icons.clear,
                  onPressed: () {
                    textEditingControllers[UserTextFielTypeEnum.id]!.clear();
                    bloc!.$streams[UserTextFielTypeEnum.id]!.onChangeField('');
                  },
                ),
              ),
              TextFieldStreamWidget(
                stream: bloc!.$streams[UserTextFielTypeEnum.fullName]!
                    .$streamField as Stream<String>,
                hintText: UserStrings.labelTextFieldFullName.i18n,
                textCapitalization: TextCapitalization.words,
                controller:
                    textEditingControllers[UserTextFielTypeEnum.fullName],
                focusNode: focusNodes[UserTextFielTypeEnum.fullName],
                onSubmitted: (valor) {
                  fieldFocusChange(
                    context,
                    focusNodes[UserTextFielTypeEnum.fullName],
                    focusNodes[UserTextFielTypeEnum.lastName],
                  );
                  bloc!.$streams[UserTextFielTypeEnum.fullName]!
                      .onChangeField(valor);
                },
                onChanged: (valor) => bloc!
                    .$streams[UserTextFielTypeEnum.fullName]!
                    .onChangeField(valor),
                prefixIcon: Icon(
                  Icons.perm_identity,
                  color: AppColors.secondaryColor.shade500,
                ),
                suffixIcon: IconButtonGenericWidget(
                  icon: Icons.clear,
                  onPressed: () {
                    textEditingControllers[UserTextFielTypeEnum.fullName]!
                        .clear();
                    bloc!.$streams[UserTextFielTypeEnum.fullName]!
                        .onChangeField('');
                  },
                ),
              ),
              TextFieldStreamWidget(
                stream: bloc!.$streams[UserTextFielTypeEnum.lastName]!
                    .$streamField as Stream<String>,
                hintText: UserStrings.labelTextFieldLastName.i18n,
                textCapitalization: TextCapitalization.none,
                controller:
                    textEditingControllers[UserTextFielTypeEnum.lastName],
                focusNode: focusNodes[UserTextFielTypeEnum.lastName],
                onSubmitted: (valor) {
                  fieldFocusChange(
                    context,
                    focusNodes[null],
                    focusNodes[null],
                  );
                  bloc!.$streams[UserTextFielTypeEnum.lastName]!
                      .onChangeField(valor);
                },
                onChanged: (valor) => bloc!
                    .$streams[UserTextFielTypeEnum.lastName]!
                    .onChangeField(valor),
                prefixIcon: Icon(
                  Icons.abc,
                  color: AppColors.secondaryColor.shade500,
                ),
                suffixIcon: IconButtonGenericWidget(
                  icon: Icons.clear,
                  onPressed: () {
                    textEditingControllers[UserTextFielTypeEnum.lastName]!
                        .clear();
                    bloc!.$streams[UserTextFielTypeEnum.lastName]!
                        .onChangeField('');
                  },
                ),
              ),
            ],
          );
        });
  }

  _restartFields() {
    textEditingControllers[UserTextFielTypeEnum.id]!.clear();
    textEditingControllers[UserTextFielTypeEnum.fullName]!.clear();
    textEditingControllers[UserTextFielTypeEnum.lastName]!.clear();
  }
}
