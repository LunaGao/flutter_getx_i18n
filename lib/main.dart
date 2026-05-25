import 'package:flutter_getx_i18n/constants.dart';
import 'package:flutter_getx_i18n/model/i18n_config.dart';
import 'package:flutter_getx_i18n/model/pubspec_parser.dart';

Future<void> generateI18nDartFile() async {
  Map<dynamic, dynamic> pubspec = PubspecParser.fromPathToMap('pubspec.yaml');
  if (!pubspec.keys.contains(i18nPubspecConfigKey)) {
    throw Exception('flutter_getx_i18n not found in pubspec.yaml');
  }
  if (!pubspec['flutter_getx_i18n'].keys.contains(i18nCsvConfigKey)) {
    throw Exception('i18n_csv not found in pubspec.yaml');
  }
  if (!pubspec['flutter_getx_i18n'].keys.contains(i18nDartConfigKey)) {
    throw Exception('i18n_dart not found in pubspec.yaml');
  }
  var i18nConfig = I18nConfig(
    csvPath: pubspec['flutter_getx_i18n']['i18n_csv'],
    dartPath: pubspec['flutter_getx_i18n']['i18n_dart'],
  );

  print(i18nConfig.csvPath);

  print(i18nConfig.dartPath);
}
