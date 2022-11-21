import 'package:i18n_extension/i18n_extension.dart';

class UserStrings {
  static const String titleAppBar = 'Users';
  static const String textButtonAdd = 'User Add';
  static const String labelTextFieldId = 'Identification';
  static const String labelTextFieldFullName = 'Full Name';
  static const String labelTextFieldLastName = 'Last Name';
}

extension Localization on String {
  static final _t = Translations('en_us') +
      {
        'en_us': UserStrings.titleAppBar,
        'es_co': 'Usuarios',
      } +
      {
        'en_us': UserStrings.textButtonAdd,
        'es_co': 'Agregar usuario',
      } +
      {
        'en_us': UserStrings.labelTextFieldId,
        'es_co': 'Identificación',
      } +
      {
        'en_us': UserStrings.labelTextFieldFullName,
        'es_co': 'Nombres',
      } +
      {
        'en_us': UserStrings.labelTextFieldLastName,
        'es_co': 'Apellidos',
      };

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

  Map<String?, String> allVersions() => localizeAllVersions(this, _t);
}
