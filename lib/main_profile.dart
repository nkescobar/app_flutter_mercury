import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_mercury_flutter/entrypoint/application/env/env_constants_profile.dart';
import 'package:app_mercury_flutter/entrypoint/application/config/app_compilation_mode.dart';
import 'package:app_mercury_flutter/entrypoint/application/config/app_settings.dart';
import 'package:app_mercury_flutter/entrypoint/application/config/application.dart';
import 'package:app_mercury_flutter/entrypoint/application/application.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  var appSettings = AppSettings(
      baseUrl: EnvConstants.apiBase, mode: AppCompilationMode.profile);
  Application().appSettings = appSettings;
  runApp(const MercuryApp());
}
