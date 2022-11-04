import 'package:app_mercury_flutter/entrypoint/application/config/index.dart'
    show AppSettings;

class Application {
  static Application? _singleton;
  AppSettings? appSettings;

  factory Application() {
    _singleton ??= Application._();
    return _singleton!;
  }

  Application._();
}
