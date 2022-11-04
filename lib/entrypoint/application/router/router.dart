import 'package:flutter/material.dart';

import 'package:app_mercury_flutter/entrypoint/application/config/index.dart';
import 'package:app_mercury_flutter/entrypoint/ui/screens/index.dart'
    show HomeScreen, CategoriesScreen;

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case AppRoutes.categoriesRoute:
        return MaterialPageRoute(
          builder: (_) => const CategoriesScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }
  }
}
