import 'package:build/build.dart';
import 'package:flutter_getx_i18n/model/i18n_config.dart';

import 'csv_i18n_builder.dart';

final I18nConfig i18nConfig = I18nConfig.getConfig();

Builder csvI18nBuilder(BuilderOptions options) => CsvI18nBuilder();
