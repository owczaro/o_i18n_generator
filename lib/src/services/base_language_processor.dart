import '../converters/map_to_dart.dart';
import '../converters/map_to_json.dart';
import '../models/command_config.dart';
import 'base_language_processor_steps/collect.dart';
import 'base_language_processor_steps/log_missing_translations.dart';
import 'base_language_processor_steps/merge_with_default_language.dart';
import 'base_language_processor_steps/redirect.dart';
import 'base_language_processor_steps/sort.dart';

/// Process [currentLanguageTag] to collect and create translation file.
abstract class BaseLanguageProcessor {
  /// Currently processed language tag.
  final String currentLanguageTag;

  /// A map containing translations for [currentLanguageTag]
  Map<String, dynamic> _translations;

  /// Gets a map of translations.
  Map<String, dynamic> get translations => _translations;

  /// Creates an instance of [LanguageProcessor]
  BaseLanguageProcessor(this.currentLanguageTag);

  /// Runs processing [currentLanguageTag]
  Future<void> run();

  /// Collects translations from packages for [currentLanguageTag]
  Future<void> collectTranslations() async {
    _translations = await CollectStep(currentLanguageTag).run();
  }

  /// After collecting all available translations for [currentLanguageTag],
  /// we know if [currentLanguageTag] has translations,
  /// so we can continue or break further processing.
  bool doesHaveTranslations() =>
      translations != null && translations.isNotEmpty;

  /// Fills missing translations of currentLanguageTag
  /// with values from [config.defaultLanguage]
  void mergeWithDefaultLanguage(
          Map<String, dynamic> defaultLanguageTranslations) =>
      _translations = MergeWithDefaultLanguageStep(
        defaultLanguageTranslations: defaultLanguageTranslations,
        currentLanguageTranslations: _translations,
      ).run();

  /// Searches [RedirectionStep.redirectionSign] and replaces value with
  /// value from key redirection.
  void redirectValues() => _translations = RedirectionStep(_translations).run();

  /// Logs which keys from translations of [currentLanguageTag] are missing
  /// (in comparison to translations of [config.defaultLanguage]).
  void logMissingTranslations(
    Map<String, dynamic> defaultLanguageTranslations,
  ) =>
      LogMissingStep(
        languageTag: currentLanguageTag,
        defaultLanguageTranslations: defaultLanguageTranslations,
        currentLanguageTranslations: _translations,
      ).run();

  /// Sorts translations by values.
  void sort() => _translations = SortStep(_translations).run();

  /// Transforms output file to given [config.extension]
  void transformToGivenExtension() {
    switch (CommandConfig.outputExtension) {
      case 'json':
        MapToJson(
          languageTag: currentLanguageTag,
          translations: _translations,
        );
        break;
      case 'dart':
        MapToDart(
          languageTag: currentLanguageTag,
          translations: _translations,
        );
        break;
      // TODO: case arb
    }
  }
}
