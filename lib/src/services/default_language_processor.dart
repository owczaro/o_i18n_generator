import '../models/command_config.dart';
import '../models/default_language_exception.dart';
import 'base_language_processor.dart';

/// Process only [config.defaultLanguage].
class DefaultLanguageProcessor extends BaseLanguageProcessor {
  /// Creates an instance of [DefaultLanguageProcessor]
  DefaultLanguageProcessor() : super(CommandConfig.defaultLanguage);

  /// Collecting translations. If there is no translations for
  /// [CommandConfig.defaultLanguage] it throws [DefaultLanguageException]
  @override
  Future<void> run() async {
    await collectTranslations();
    if (!doesHaveTranslations()) {
      throw DefaultLanguageException('No translations '
          'for default language ($currentLanguageTag)');
    }

    redirectValues();
    sort();
    transformToGivenExtension();
  }
}
