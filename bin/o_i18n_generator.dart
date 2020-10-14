import 'dart:io';

import 'package:args/args.dart';
import 'package:o_i18n_generator/src/data/input_extensions.dart';
import 'package:o_i18n_generator/src/data/output_extensions.dart';
import 'package:o_i18n_generator/src/models/command_config.dart';
import 'package:o_i18n_generator/src/models/default_language_exception.dart';
import 'package:o_i18n_generator/src/o_i18n_generator_command.dart';
import 'package:path/path.dart' as path;
import 'package:o_i18n_generator/src/data/language_tags.dart';

Future<void> main(List<String> arguments) async {
  const logMissingFlag = 'log';
  const logDirOption = 'log-dir';
  const sourceDirOption = 'source-dir';
  const targetDirOption = 'target-dir';
  const outputExtensionOption = 'output-extension';
  const inputExtensionOption = 'input-extension';
  const defaultLanguageOption = 'main-language';
  const languagesOption = 'languages';
  const excludePackagesOption = 'exclude-packages';

  final parser = ArgParser();

  parser
    ..addFlag(
      'help',
      abbr: 'h',
      defaultsTo: false,
      callback: (val) {
        if (val) {
          print('${parser.usage}\n\n');
          exit(0);
        }
      },
      negatable: false,
    )
    ..addFlag(
      logMissingFlag,
      help: 'If true, saves reports about missing translations '
          'or redirection loops to <log-dir>',
      defaultsTo: CommandConfig.logMissing,
      negatable: false,
    )
    ..addOption(
      logDirOption,
      defaultsTo: CommandConfig.logDir,
      valueHelp: 'dir_path',
      help: 'The directory used to save missing translations logs',
    )
    ..addOption(
      sourceDirOption,
      defaultsTo: CommandConfig.sourceDir,
      valueHelp: 'dir_path',
      help: 'The directory where translations files have been placed',
    )
    ..addOption(
      targetDirOption,
      defaultsTo: CommandConfig.targetDir,
      valueHelp: 'dir_path',
      help: 'The directory used to save generated translations',
    )
    ..addOption(
      outputExtensionOption,
      defaultsTo: CommandConfig.outputExtension,
      allowed: outputExtensions,
      allowedHelp: {
        'dart': 'Use when you want to use generated files without waiting to '
            'assets, \nyou can generate .g.dart files to [target-dir] and use '
            '[BasicLocaleLoader] to load translations synchronously',
        'json': 'Use when you want to save generates files to assets '
            'and load them asynchronously. It generates .g.json files',
      },
      valueHelp: 'extension',
      help: 'Extension of generated translation files - WITHOUT A DOT',
    )
    ..addMultiOption(
      inputExtensionOption,
      defaultsTo: CommandConfig.inputExtensions,
      allowed: inputExtensions,
      valueHelp: 'extensions',
      help: 'Extensions of source files - WITHOUT A DOT',
    )
    ..addOption(
      defaultLanguageOption,
      defaultsTo: CommandConfig.defaultLanguage,
      allowed: languageTagsAndNames.keys,
      allowedHelp: languageTagsAndNames,
      valueHelp: 'language_tag',
      help: 'Default language, when there is no key translation in a language\n'
          'Available values:',
    )
    ..addMultiOption(
      languagesOption,
      defaultsTo: CommandConfig.languages,
      allowed: languageTagsAndNames.keys,
      allowedHelp: languageTagsAndNames,
      valueHelp: 'comma_separated_language_tags',
      help: 'Languages to process.\n Available values:',
    )
    ..addMultiOption(
      excludePackagesOption,
      defaultsTo: CommandConfig.excludePackages,
      valueHelp: 'comma_separated_packages_names',
      help: 'Packages to exclude from collecting process',
    );

  try {
    final results = parser.parse(arguments);

    CommandConfig(
      logMissing: results[logMissingFlag],
      logDir: path.normalize(results[logDirOption]),
      sourceDir: path.normalize(results[sourceDirOption]),
      targetDir: path.normalize(results[targetDirOption]),
      outputExtension: results[outputExtensionOption],
      inputExtensions: results[inputExtensionOption],
      defaultLanguage: results[defaultLanguageOption],
      languages: results[languagesOption],
      excludePackages: results[excludePackagesOption],
    );

    OI18nGeneratorCommand().run();
  } on FormatException catch (e) {
    print(e.toString());
    exit(1);
  } on DefaultLanguageException catch (e) {
    print(e.toString());
    exit(1);
  }
}
