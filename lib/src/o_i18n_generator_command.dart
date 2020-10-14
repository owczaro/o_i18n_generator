import 'dart:io';

import 'models/command_config.dart';
import 'models/default_language_exception.dart';
import 'services/default_language_processor.dart';
import 'services/language_processor.dart';
import 'services/loader_creator.dart';
import 'utls/file_utils.dart';

/// A class responsible for generation process.
class OI18nGeneratorCommand {
  /// Runs generation process.
  Future<void> run() async {
    await _clearDirs();
    final defaultLanguageProcessor = DefaultLanguageProcessor();
    var translatedLanguageTags = <String>[];
    try {
      await defaultLanguageProcessor.run();
      for (var languageTag in CommandConfig.languages) {
        final languageProcessor = LanguageProcessor(
          languageTag,
          defaultLanguageProcessor.translations,
        );
        await languageProcessor.run();
        if (languageProcessor.doesHaveTranslations()) {
          translatedLanguageTags.add(languageTag);
        }
      }
    } on DefaultLanguageException catch (_) {
      rethrow;
    }

    if (CommandConfig.outputExtension == 'dart') {
      LoaderCreator(translatedLanguageTags);
    }

    if (Directory(CommandConfig.targetDir).existsSync()) {
      print('Generated files are in ${CommandConfig.targetDir}');
    }
  }

  /// Clears [targetDir], because can be messy there and it causes
  /// translation errors, performance issues
  /// and - in case of [logDir] - ambiguities.
  /// If you want to overwrite translation,
  /// you can do it in proper language-tag file in [CollectStep.sourceDir2].
  Future<void> _clearDirs() async {
    if (CommandConfig.logMissing) {
      await deleteDir(CommandConfig.logDir);
    }
    await deleteDir(CommandConfig.targetDir);
  }
}
