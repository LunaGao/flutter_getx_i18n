import 'package:flutter_getx_i18n/constants.dart';
import 'package:flutter_getx_i18n/model/pubspec_parser.dart';

class I18nConfig {
  String csvPath = '/i18n.csv';
  String dartPath = '/i18n.dart';

  I18nConfig._();

  static I18nConfig getConfig() {
    Map<dynamic, dynamic> pubspec = PubspecParser.fromPathToMap('pubspec.yaml');
    if (!pubspec.keys.contains(i18nPubspecConfigKey)) {
      throw Exception('flutter_getx_i18n not found in pubspec.yaml');
    }
    if (!pubspec['flutter_getx_i18n'].keys.contains(i18nCsvConfigKey)) {
      throw Exception('i18n_csv not found in pubspec.yaml');
    }
    var i18nConfig = I18nConfig._();
    i18nConfig.csvPath = pubspec[i18nPubspecConfigKey][i18nCsvConfigKey];
    i18nConfig.dartPath = i18nConfig.csvPath.replaceAll('.csv', '.dart');
    return i18nConfig;
  }
}
