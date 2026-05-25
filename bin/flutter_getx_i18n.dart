import 'package:flutter_getx_i18n/constants.dart';
import 'package:flutter_getx_i18n/main.dart';
import 'package:flutter_getx_i18n/src/version.dart';

void main(List<String> arguments) {
  print(introMessage(packageVersion));
  generateI18nDartFile();
}
