import 'package:flutter/material.dart';

import 'package:app_mercury_flutter/entrypoint/application/config/index.dart';
import 'package:app_mercury_flutter/entrypoint/ui/screens/index.dart'
    show CategoriesScreen, HomeScreen, UserScreen;
import 'package:i18n_extension/i18n_widget.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => I18n(child: const HomeScreen()),
        );
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => I18n(child: const HomeScreen()),
        );
      case AppRoutes.categoriesRoute:
        return MaterialPageRoute(
          builder: (_) => I18n(child: const CategoriesScreen()),
        );
      case AppRoutes.usersRoute:
        return MaterialPageRoute(
          builder: (_) => I18n(child: const UserScreen()),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => I18n(child: const HomeScreen()),
        );
    }
  }
}
