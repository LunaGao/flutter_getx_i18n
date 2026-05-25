import 'package:flutter_getx_i18n/pubspec_parser.dart';

Future<void> generateI18nDartFile() async {
  Map<dynamic, dynamic> pubspec = PubspecParser.fromPathToMap('pubspec.yaml');

  print(pubspec);
}
