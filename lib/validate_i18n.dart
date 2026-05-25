class ValidateI18n {
  static void validateAppI18nCSVContent({
    required List<List<dynamic>> csvData,
    required String fileName,
  }) {
    if (csvData.isEmpty) {
      throw Exception('$fileName is empty.');
    }
  }
}
