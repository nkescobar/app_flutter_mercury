import 'package:flutter/material.dart';

class AppColors {
  static const int _primarColorValue = 0xFFCC0000;
  static const int _accentColorValue = 0xFF5479FF;
  static const int _secondaryColorValue = 0xFFF57E31;

  static const Map<int, Color> primaryColorCodes = {
    50: Color(0xFFF9E0E0),
    100: Color(0xFFF0B3B3),
    200: Color(0xFFE68080),
    300: Color(0xFFDB4D4D),
    400: Color(0xFFD42626),
    500: Color(_primarColorValue),
    600: Color(0xFFC70000),
    700: Color(0xFFC00000),
    800: Color(0xFFB90000),
    900: Color(0xFFAD0000),
  };

  static const Map<int, Color> accentColorCodes = {
    100: Color(0xFF87A1FF),
    200: Color(_accentColorValue),
    400: Color(0xFF2151FF),
    700: Color(0xFF083DFF),
  };

  static const Map<int, Color> secondaryColorCodes = {
    50: Color(0xFFFEF0E6),
    100: Color(0xFFFCD8C1),
    200: Color(0xFFFABF98),
    300: Color(0xFFF8A56F),
    400: Color(0xFFF79150),
    500: Color(_secondaryColorValue),
    600: Color(0xFFF4762C),
    700: Color(0xFFF26B25),
    800: Color(0xFFF0611F),
    900: Color(0xFFEE4E13),
  };

  static const MaterialColor primaryColor =
      MaterialColor(_primarColorValue, primaryColorCodes);

  static const MaterialColor accentColor =
      MaterialColor(_accentColorValue, accentColorCodes);

  static const MaterialColor secondaryColor =
      MaterialColor(_secondaryColorValue, secondaryColorCodes);

  static const Color hintColor = Color(0xFFBDBDBD);
  static const Color scaffoldBackgroundColor = Color(0xFFFFFFFF);
  static const Color icons = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFBDBDBD);

  static const Color primaryText = Color(0xFF212121);
  static const Color secondaryText = Color(0xFF757575);

  static const Color errorColor = Color(0xFFB00020);
  static const Color infoColor = Color(0xFF2196F3);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color successColor = Color(0xFF2E7D32);
  static const Color normalColor = Color(0xFF2D3243);

  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color greyColor = Color(0xFFCFD8DC);
  static const Color defaultColor = Color(0xFFF4F5F7);
  static const Color blackColor = Color(0xFF2D3243);
}
