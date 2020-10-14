import '../models/command_config.dart';
import 'base_language_processor.dart';

/// Process all language tags except default language tag.
class LanguageProcessor extends BaseLanguageProcessor {
  /// A map of translations of [CommandConfig.defaultLanguage]
  final Map<String, dynamic> defaultTranslations;

  /// Creates an instance of [LanguageProcessor]
  LanguageProcessor(String currentLanguageTag, this.defaultTranslations)
      : assert(CommandConfig.defaultLanguage != currentLanguageTag),
        super(currentLanguageTag);

  @override
  Future<void> run() async {
    await collectTranslations();
    if (!doesHaveTranslations()) {
      return null;
    }

    await mergeWithDefaultLanguage(defaultTranslations);
    redirectValues();

    if (CommandConfig.logMissing) {
      logMissingTranslations(defaultTranslations);
    }

    sort();
    transformToGivenExtension();
  }
}
