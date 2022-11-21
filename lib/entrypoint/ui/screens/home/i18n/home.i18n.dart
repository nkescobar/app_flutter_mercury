import 'package:i18n_extension/i18n_extension.dart';

class HomeStrings {
  static const String home = 'Home!';
  static const String welcome = 'Welcome';
  static const String categories = 'Categories';
  static const String users = 'Users';
}

extension Localization on String {
  static final _t = Translations('en_us') +
      {
        'en_us': HomeStrings.home,
        'es_co': 'Inicio!',
      } +
      {
        'en_us': HomeStrings.welcome,
        'es_co': 'Bienvenido',
      } +
      {
        'en_us': HomeStrings.categories,
        'es_co': 'Categorias',
      } +
      {
        'en_us': HomeStrings.users,
        'es_co': 'Usuarios',
      };

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

  Map<String?, String> allVersions() => localizeAllVersions(this, _t);
}
