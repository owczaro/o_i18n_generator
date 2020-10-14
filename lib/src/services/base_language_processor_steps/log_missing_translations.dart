import 'package:meta/meta.dart';

import 'package:deep_collection/deep_collection.dart';
import 'package:merge_map/merge_map.dart';
import 'package:path/path.dart' as path;

import '../../models/command_config.dart';
import '../../utls/file_utils.dart';
import 'redirect.dart';

/// A logger of translations missing in [currentLanguageTranslations]
/// in comparision with [currentLanguageTranslations].
///
/// It merges result of:
/// * intersection between values of
/// [defaultLanguageTranslations] and [currentLanguageTranslations]
/// * difference between keys of
/// [defaultLanguageTranslations] and [currentLanguageTranslations]
/// * not redirected values in [currentLanguageTranslations]
class LogMissingStep {
  /// Language to process.
  final String languageTag;

  /// A map of translations of [CommandConfig.defaultLanguage]
  final Map<String, dynamic> defaultLanguageTranslations;

  /// A map of translations of [languageTag]
  final Map<String, dynamic> currentLanguageTranslations;

  /// A subdirectory, where logs are saved.
  static const logSubDir = 'missing_translations';

  /// The directory, where this logger saves logs.
  static String get targetDir =>
      path.normalize('${CommandConfig.logDir}/$logSubDir');

  /// Creates an instance on [LogMissingStep]
  LogMissingStep({
    @required this.languageTag,
    @required this.defaultLanguageTranslations,
    @required this.currentLanguageTranslations,
  });

  /// Runs the process. Returns a map of missing values - [missingItems]
  Map<String, dynamic> run() {
    final missingItems = mergeMap([
      _missingTranslations(
        defaultLanguageTranslations,
        currentLanguageTranslations,
      ),
      _missingRedirections(currentLanguageTranslations)
    ]).cast<String, dynamic>();

    if (missingItems.isNotEmpty) {
      final languageLogFile =
          openFile(path.normalize('$targetDir/$languageTag.json'));
      saveMapToFile(missingItems, languageLogFile);
    }

    return missingItems;
  }

  Map<String, dynamic> _missingRedirections(Map<String, dynamic> languageMap) {
    return languageMap
        .deepSearchByValue((value) =>
            value is String && value.contains(RedirectionStep.redirectionSign))
        .cast<String, dynamic>();
  }

  Map<String, dynamic> _missingTranslations(
      Map<String, dynamic> defaultLanguageMap,
      Map<String, dynamic> languageMap) {
    return {
      ...defaultLanguageMap
          .deepIntersectionByValue(languageMap)
          .cast<String, dynamic>(),
      ...defaultLanguageMap
          .deepDifferenceByKey(languageMap)
          .cast<String, dynamic>(),
    };
  }
}
