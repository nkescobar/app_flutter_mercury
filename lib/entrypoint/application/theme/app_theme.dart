import 'package:app_mercury_flutter/entrypoint/application/config/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    dividerColor: AppColors.divider,
    hintColor: AppColors.hintColor,
    appBarTheme: AppBarTheme(
      color: AppColors.primaryColor.shade500,
      iconTheme: const IconThemeData(
        color: AppColors.icons,
      ),
    ),
    primarySwatch: AppColors.primaryColor,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor.shade500,
      secondary: AppColors.secondaryColor.shade500,
      onSecondary: AppColors.whiteColor,
    ),
    errorColor: AppColors.errorColor,
    cardTheme: const CardTheme(
      color: AppColors.whiteColor,
    ),
    iconTheme: const IconThemeData(
        // color: AppColors.icons,
        ),
    textTheme: GoogleFonts.openSansTextTheme().copyWith(
      headline6: GoogleFonts.openSansTextTheme().headline6!.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
      subtitle1: GoogleFonts.openSansTextTheme().subtitle1!.copyWith(
            color: AppColors.blackColor,
            fontWeight: FontWeight.normal,
          ),
      subtitle2: GoogleFonts.openSansTextTheme().subtitle2!.copyWith(
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.greyColor;
          }
          return AppColors.defaultColor;
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return AppColors.primaryColor.shade50;
          }
          return Colors.transparent;
        }),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          );
        }),
        padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>((_) {
          return const EdgeInsets.all(
            AppStyles.paddingM,
          );
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.greyColor;
          }
          return AppColors.whiteColor;
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return AppColors.primaryColor.shade50;
          }
          return Colors.transparent;
        }),
        side: MaterialStateProperty.resolveWith((states) {
          Color borderColor;
          double width = 2.0;

          if (states.contains(MaterialState.disabled)) {
            borderColor = Colors.transparent;
            width = 0.0;
          } else if (states.contains(MaterialState.pressed)) {
            borderColor = AppColors.primaryColor.shade300;
          } else {
            borderColor = AppColors.primaryColor;
          }

          return BorderSide(color: borderColor, width: width);
        }),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          );
        }),
        padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>((_) {
          return const EdgeInsets.all(
            AppStyles.paddingM,
          );
        }),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          );
        }),
        padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>((_) {
          return const EdgeInsets.all(
            AppStyles.paddingM,
          );
        }),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.greyColor,
          width: AppStyles.spaceXS,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primaryColor.shade100,
          width: AppStyles.spaceXS,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.secondaryColor.shade300,
          style: BorderStyle.solid,
          width: AppStyles.spaceXS,
        ),
      ),
    ),
  );
}
