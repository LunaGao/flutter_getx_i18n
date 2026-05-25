![flutter_getx_i18n](https://socialify.git.ci/LunaGao/flutter_getx_i18n/image?description=1&font=Inter&language=1&name=1&owner=1&pattern=Circuit+Board&theme=Light)


[![Bless](https://img.shields.io/badge/bless-God-brightgreen)](https://lunagao.github.io/BlessYourCodeTag/)
![Pub Version](https://img.shields.io/pub/v/flutter_getx_i18n)

# Flutter Getx I18n

A code generation tool for Flutter GetX internationalization that converts CSV files into type-safe Dart translation classes.

## Features

- Convert CSV files to GetX `Translations` class
- Support multiple languages in a single CSV file
- Automatic language alias handling (zh_CN ↔ zh_Hans, zh_TW ↔ zh_Hant)
- Built-in validation for CSV format
- Type-safe key access
- Display value mapping for language selection UI

## Getting Started

### Prerequisites

- Dart SDK >= 3.0.0
- Flutter GetX package

### Installation

Add the following lines to your `pubspec.yaml` file:

```yaml
dependencies:
  get: ^4.6.5

dev_dependencies:
  flutter_getx_i18n: ^0.0.1
```

### Configuration

Add the build configuration to your `pubspec.yaml`:

```yaml
flutter_getx_i18n:
  i18n_csv: lib/i18n.csv   # <--- This is your CSV file path
```

### CSV File Format

NOTE: The csv file must in lib folder. DO NOT put it in assets folder.

Create a CSV file with the following format:

| key | en\|English | zh_Hans\|简体中文 | ja\|日本語 |
| ------------- | ------------- | ------------- | ------------- |
| hello     | Hello    | 你好     | こんにちは |
| welcome   | Welcome  | 欢迎     | ようこそ  |
| button_ok | OK       | 确定     | OK       |

**Note:** The header row format is `locale|displayName`. For example:
- `en|English`
- `zh_Hans|简体中文`
- `ja|日本語`

## Usage

### 1. Create your CSV file

```csv
key,en|English,zh_Hans|简体中文,ja|日本語
hello,Hello,你好,こんにちは
welcome,Welcome,欢迎,ようこそ
button_ok,OK,确定,OK
```

### 2. Run the build

```sh
dart run build_runner build
```

### 3. Use in your app

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'i18n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppI18N(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      home: Scaffold(
        appBar: AppBar(title: Text('hello'.tr)),
        body: Center(
          child: Text('welcome'.tr),
        ),
      ),
    );
  }
}
```

## Generated Code

The tool generates a Dart class like this:

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:get/get.dart';

class AppI18N extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    final keys = {
      'en': {
        'hello': 'Hello',
        'welcome': 'Welcome',
      },
      'zh_Hans': {
        'hello': '你好',
        'welcome': '欢迎',
      },
    };
    keys['zh_CN'] = keys['zh_Hans']!;
    return keys;
  }

  Map<String, String> get key2DisplayValue => {
        'en': 'English',
        'zh_Hans': '简体中文',
      };
}
```

## Language Aliases

The tool automatically creates aliases for:
- `zh_CN` → `zh_Hans`
- `zh_TW` → `zh_Hant`

This ensures compatibility across different device locale formats.

## Validation

The tool validates the CSV file for:
- Proper header format
- Non-empty key column
- Consistent row length
- Valid locale format

## Example

See the `example/` directory for a complete working example.

## License

BSD 2-Clause License

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for details.