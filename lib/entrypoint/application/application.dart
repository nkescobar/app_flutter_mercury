import 'package:app_mercury_flutter/entrypoint/application/config/app_routes.dart';
import 'package:app_mercury_flutter/entrypoint/application/router/router.dart';
import 'package:app_mercury_flutter/entrypoint/application/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:app_mercury_flutter/entrypoint/application/config/index.dart'
    show AppStrings;

class MercuryApp extends StatefulWidget {
  const MercuryApp({Key? key}) : super(key: key);

  @override
  State<MercuryApp> createState() => _MercuryAppState();
}

class _MercuryAppState extends State<MercuryApp> {
  final _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return GestureDetector(
      onTap: _handleUserInteractionOnTap,
      child: MaterialApp(
        navigatorKey: _navKey,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        // Lenguajes soportados por flutter y que nos permite
        // aplicarlo a cualquier componente, como el de la fecha
        supportedLocales: const [
          Locale('en', 'US'), // English
          Locale('es', 'CO'), // Spanish
        ],
        debugShowCheckedModeBanner: false,
        title: AppStrings.tituloApp,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRoutes.initialRoute,
        theme: AppTheme.lightTheme,
      ),
    );
  }

  void _handleUserInteractionOnTap([_]) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
