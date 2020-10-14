import '../../o_i18n_generator.dart';
import '../models/command_config.dart';

/// A class which filters language tags.
class LanguageTagsFilter {
  LanguageTagsFilter._();

  /// Removes language tags which does not exist in [languageTagsAndNames]
  /// to prevent processing errors.
  static List<String> filter(List<String> languages) => languages != null
      ? (languages
        ..removeWhere((lang) => !languageTagsAndNames.keys.contains(lang)))
      : null;

  /// Removes default language tag to prevent processing duplication
  /// and to give possibility to process default language differently.
  static List<String> removeDefaultLanguage(List<String> languages) =>
      languages != null
          ? (languages
            ..removeWhere((lang) => lang == CommandConfig.defaultLanguage))
          : null;
}
