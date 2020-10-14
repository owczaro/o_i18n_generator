import 'package:path/path.dart' as path;

import '../data/input_extensions.dart' as source_data;
import '../data/language_tags.dart';
import '../data/output_extensions.dart';
import '../filters/input_extensions.dart';
import '../filters/language_tags.dart';
import '../validators/output_extension.dart';

/// A singleton, which keeps configuration of a command.
class CommandConfig {
  /// If true, saves reports about missing translations to <log-dir>
  /// Missing translations means, there is a key in `defaultLanguage`
  /// but there is no translation in a language to process.
  static bool _logMissing;

  /// Gets [_logMissing]
  static bool get logMissing => _logMissing ?? false;

  /// The directory used to save missing translations logs.
  static String _logDir;

  /// Gets [_logDir]
  static String get logDir => _logDir ?? path.normalize('$targetDir/logs');

  /// The directory where translations files have been placed.
  static String _sourceDir;

  /// Gets [_sourceDir]
  static String get sourceDir => _sourceDir ?? path.normalize('lib/src/i18n');

  /// The directory used to save generated translations.
  static String _targetDir;

  /// Gets [_targetDir]
  static String get targetDir => _targetDir ?? path.normalize('lib/o_i18n');

  /// Extension of generated translation files. Allowed: [outputExtensions].
  static String _outputExtension;

  /// Gets [_outputExtension]
  static String get outputExtension => _outputExtension ?? 'dart';

  /// Allowed extensions of source files. Allowed: [source_data.inputExtensions]
  static List<String> _inputExtensions;

  /// Gets [_inputExtensions]
  static List<String> get inputExtensions =>
      _inputExtensions ?? <String>[...source_data.inputExtensions];

  /// Default language, when there is no translation of a key in a language.
  /// Available values: any key from [languageTagsAndNames]
  static String _defaultLanguage;

  /// Gets [_defaultLanguage]
  static String get defaultLanguage => _defaultLanguage ?? 'en-US';

  /// Languages to process.
  /// Available values: keys from [languageTagsAndNames]
  static List<String> _languages;

  /// Gets [_languages]
  static List<String> get languages =>
      _languages ?? <String>[...languageTagsAndNames.keys];

  /// Packages to exclude from collecting process.
  static List<String> _excludePackages;

  /// Gets [_excludePackages]
  static List<String> get excludePackages => _excludePackages ?? <String>[];

  static final CommandConfig _singleton = CommandConfig._internal();

  CommandConfig._internal();

  /// Creates an instance of [CommandConfig]
  factory CommandConfig({
    bool logMissing,
    String logDir,
    String sourceDir,
    String targetDir,
    String outputExtension,
    List<String> inputExtensions,
    String defaultLanguage,
    List<String> excludePackages = const [],
    List<String> languages,
  }) {
    _logMissing = logMissing;
    _logDir = logDir;
    _sourceDir = sourceDir;
    _targetDir = targetDir;
    _defaultLanguage = defaultLanguage;
    _excludePackages = excludePackages;

    _outputExtension = OutputExtensionValidator.validate(outputExtension)
        ? outputExtension
        : CommandConfig.outputExtension;

    inputExtensions = InputExtensionsFilter.filter(inputExtensions) ??
        CommandConfig.inputExtensions;

    languages = LanguageTagsFilter.filter(languages) ?? CommandConfig.languages;
    languages = LanguageTagsFilter.removeDefaultLanguage(languages);

    _inputExtensions = inputExtensions;
    _languages = languages;

    return _singleton;
  }
}
