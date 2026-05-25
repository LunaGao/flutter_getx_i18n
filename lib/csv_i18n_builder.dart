import 'package:csv/csv.dart';
import 'package:build/build.dart';
import 'package:flutter_getx_i18n/builder.dart';
import 'package:flutter_getx_i18n/model/language_column.dart';
import 'package:flutter_getx_i18n/validate_i18n.dart';

class CsvI18nBuilder implements Builder {
  @override
  Future build(BuildStep buildStep) async {
    // Each [buildStep] has a single input.
    final inputId = buildStep.inputId;

    // Create a new target [AssetId] based on the old one.
    final contents = await buildStep.readAsString(inputId);
    final codec = Csv(
      lineDelimiter: '\n',
    );
    final csvData = codec.decode(contents);

    // Validate CSV data.
    ValidateI18n.validateAppI18nCSVContent(
      csvData: csvData,
      fileName: inputId.path,
    );
    final generatedFile = inputId.changeExtension('.dart');

    // Write out the new asset.
    await buildStep.writeAsString(generatedFile, generateDartCode(csvData));
  }

  @override
  final buildExtensions = {
    i18nConfig.csvPath: [i18nConfig.dartPath],
  };

  /// Generate Dart code from CSV data.
  String generateDartCode(List<List<dynamic>> csvData) {
    var headerRow = csvData[0];
    var languageColumns = getLanguageColumns(headerRow);
    var languageMap = buildLanguageMap(
      csvData: csvData,
      languageColumns: languageColumns,
    );
    var displayValueMap = buildDisplayValueMap(languageColumns);
    var languageAliases = buildLanguageAliasAssignments(languageColumns);

    return [
      '// GENERATED CODE - DO NOT MODIFY BY HAND',
      '',
      'import \'package:get/get.dart\';',
      '',
      'class AppI18N extends Translations {',
      '  @override',
      '  Map<String, Map<String, String>> get keys {',
      '    final keys = {',
      languageMap,
      '    };',
      ...languageAliases,
      '    return keys;',
      '  }',
      '',
      '  Map<String, String> get key2DisplayValue => {',
      displayValueMap,
      '      };',
      '}',
      '',
    ].join('\n');
  }

  List<LanguageColumn> getLanguageColumns(List<dynamic> headerRow) {
    var languageColumns = <LanguageColumn>[];
    for (var i = 1; i < headerRow.length; i++) {
      var parts = headerRow[i].split('|');
      languageColumns.add(
        LanguageColumn(
          index: i,
          locale: parts[0] as String,
          displayName: parts[1] as String,
        ),
      );
    }
    return languageColumns;
  }

  String buildLanguageMap({
    required List<List<dynamic>> csvData,
    required List<LanguageColumn> languageColumns,
  }) {
    var rows = csvData.sublist(1);

    return languageColumns.map(
      (languageColumn) {
        var translatedRows = rows.map((row) {
          return '''        '${row[0]}': '${row[languageColumn.index]}',''';
        }).join('\n');

        return [
          '''      '${languageColumn.locale}': {''',
          translatedRows,
          '      },',
        ].join('\n');
      },
    ).join('\n');
  }

  String buildDisplayValueMap(List<LanguageColumn> languageColumns) {
    return languageColumns.map(
      (languageColumn) {
        return '''        '${languageColumn.locale}': '${languageColumn.displayName}',''';
      },
    ).join('\n');
  }

  List<String> buildLanguageAliasAssignments(
    List<LanguageColumn> languageColumns,
  ) {
    var aliases = <String>[];
    if (languageColumns
        .where((element) => element.locale == 'zh_Hans')
        .isNotEmpty) {
      aliases.add('    keys[\'zh_CN\'] = keys[\'zh_Hans\']!;');
    }
    if (languageColumns
        .where((element) => element.locale == 'zh_Hant')
        .isNotEmpty) {
      aliases.add('    keys[\'zh_TW\'] = keys[\'zh_Hant\']!;');
    }
    return aliases;
  }
}
