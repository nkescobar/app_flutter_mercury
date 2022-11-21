import 'package:flutter/material.dart';
// Configurations
import 'package:app_mercury_flutter/entrypoint/application/config/index.dart'
    show AppStyles;
import 'package:app_mercury_flutter/entrypoint/di/injector.dart';
// Widgets shared
import 'package:app_mercury_flutter/entrypoint/ui/shared/index.dart'
    show BaseStateBloc, ButtonStreamLoadingWidget, ButtonTypeEnum;
import 'package:app_mercury_flutter/entrypoint/ui/screens/users/widgets/user_list_widget/user_list_widget.dart';
import 'package:app_mercury_flutter/entrypoint/ui/screens/users/widgets/user_form_widget/user_form_widget.dart';

// BLoc
import 'package:app_mercury_flutter/entrypoint/blocs/users/index.dart'
    show UserBloc;

import 'enums/user_textfield_type_enum.dart';
import 'i18n/user.i18n.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends BaseStateBloc<UserScreen, UserBloc> {
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
    return UserBloc(Injector().provideAddUserUseCase(),
        Injector().provideGetUsersUseCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UserStrings.titleAppBar.i18n),
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
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const UserFormWidget(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppStyles.paddingL,
                        ),
                        child: StreamBuilder<bool>(
                            stream: bloc!.$formularioValido,
                            builder: (context, snapshot) {
                              return ButtonStreamLoadingWidget(
                                text: UserStrings.textButtonAdd.i18n,
                                isLoading: bloc!.$loadingCategory,
                                buttonTypeEnum:
                                    ButtonTypeEnum.buttonActionMainPositive,
                                onPressed:
                                    (snapshot.hasData && snapshot.data == true)
                                        ? () => _addUser(context)
                                        : bloc!.validateFormAndShowErrors,
                              );
                            }),
                      ),
                      StreamBuilder<bool>(
                          stream: bloc!.$loadingCategory,
                          builder: (context, snapshotLoading) {
                            if (snapshotLoading.hasData &&
                                snapshotLoading.data == false) {
                              return UserListWidget(
                                users: bloc!.$users,
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addUser(BuildContext context) async {
    fieldFocusChange(context, null, null);
    await bloc!.addUser();
    await bloc!.getUsers();
    bloc!.$streams[UserTextFielTypeEnum.id]!.onChangeField('');
    bloc!.$streams[UserTextFielTypeEnum.fullName]!.onChangeField('');
    bloc!.$streams[UserTextFielTypeEnum.lastName]!.onChangeField('');
  }
}
