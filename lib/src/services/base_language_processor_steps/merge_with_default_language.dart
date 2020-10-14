import 'package:merge_map/merge_map.dart';
import 'package:meta/meta.dart';

/// A step of merging language files of given language tag with default language
/// in order to fill missing translations.
class MergeWithDefaultLanguageStep {
  /// A map of translations of [CommandConfig.defaultLanguage]
  final Map<String, dynamic> defaultLanguageTranslations;

  /// A map of translations of currently processing language.
  final Map<String, dynamic> currentLanguageTranslations;

  /// Creates an instance of [MergeWithDefaultLanguageStep]
  MergeWithDefaultLanguageStep({
    @required this.defaultLanguageTranslations,
    @required this.currentLanguageTranslations,
  });

  /// Runs the process. Returns merged
  /// [defaultLanguageTranslations] and [currentLanguageTranslations]
  Map<String, dynamic> run() => mergeMap([
        defaultLanguageTranslations,
        currentLanguageTranslations,
      ]);
}
