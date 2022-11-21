import 'package:flutter/material.dart';
import 'package:app_mercury_flutter/entrypoint/application/config/index.dart';
// Shared
import 'package:app_mercury_flutter/entrypoint/ui/shared/index.dart'
    show ButtonMainActionPositiveWidget;
import './i18n/home.i18n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HomeStrings.home.i18n),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppStyles.paddingXL),
                  child: Text(
                    HomeStrings.welcome.i18n,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonMainActionPositiveWidget(
                    text: HomeStrings.categories.i18n,
                    onPressed: () => _navegarCategory(),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonMainActionPositiveWidget(
                    text: HomeStrings.users.i18n,
                    onPressed: () => _navegarUser(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navegarCategory() {
    Navigator.pushNamed(context, AppRoutes.categoriesRoute);
  }

  void _navegarUser() {
    Navigator.pushNamed(context, AppRoutes.usersRoute);
  }
}
