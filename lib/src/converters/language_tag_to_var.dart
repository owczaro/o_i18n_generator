/// A converter, which converts a language tag
/// to a variable name - variables can't have '-' sign.
class LanguageTagToVar {
  LanguageTagToVar._();

  /// Converts given [languageTag]
  static String convert(String languageTag) => languageTag.replaceAll('-', '');
}
