import 'package:o_i18n_generator/src/data/input_extensions.dart' as source;
import 'package:o_i18n_generator/src/models/command_config.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

/// Tests [CommandConfig]

Future<void> main() async {
  group('[Models] CommandConfig - default values', () {
    setUpAll(() => CommandConfig());

    test('logMissing', () => expect(CommandConfig.logMissing, false));

    test('logDir',
        () => expect(CommandConfig.logDir, path.normalize('lib/o_i18n/logs')));

    test('sourceDir',
        () => expect(CommandConfig.sourceDir, path.normalize('lib/src/i18n')));

    test('targetDir',
        () => expect(CommandConfig.targetDir, path.normalize('lib/o_i18n')));

    test(
        'outputExtension', () => expect(CommandConfig.outputExtension, 'dart'));

    test(
        'inputExtensions',
        () =>
            expect(CommandConfig.inputExtensions, [...source.inputExtensions]));

    test('defaultLanguage',
        () => expect(CommandConfig.defaultLanguage, 'en-US'));

    test(
        'languages',
        () => expect(CommandConfig.languages, [
              'af-ZA',
              'az-AZ',
              'id-ID',
              'ms-MY',
              'bs-BA',
              'ca-ES',
              'cy-GB',
              'da-DK',
              'de-DE',
              'de-CH',
              'de-AT',
              'et-EE',
              'en-AU',
              'en-CA',
              'en-IE',
              'en-NZ',
              'en-GB',
              // 'en-US',
              'es-AR',
              'es-CL',
              'es-CO',
              'es-CR',
              'es-ES',
              'es-MX',
              'es-PA',
              'es-PE',
              'es-VE',
              'fil-PH',
              'fr-CA',
              'fr-FR',
              'gl-ES',
              'hr-HR',
              'it-IT',
              'it-CH',
              'sw-KE',
              'lv-LV',
              'lt-LT',
              'hu-HU',
              'nl-NL',
              'nb-NO',
              'nn-NO',
              'pl-PL',
              'pt-BR',
              'pt-PT',
              'ro-RO',
              'sq-AL',
              'sk-SK',
              'sl-SI',
              'sr-RS',
              'fi-FI',
              'sv-SE',
              'vi-VN',
              'tr-TR',
              'is-IS',
              'cs-CZ',
              'el-GR',
              'be-BY',
              'bg-BG',
              'mk-MK',
              'mn-MN',
              'ru-RU',
              'uk-UA',
              'he-IL',
              'ar-DZ',
              'ar-KW',
              'ar-MA',
              'ar-SA',
              'ar-EG',
              'fa-IR',
              'hi-IN',
              'bn-BD',
              'gu-IN',
              'th-TH',
              'lo-LA',
              'ka-GE',
              'km-KH',
              'zh-CN',
              'zh-HK',
              'zh-TW',
              'ja-JP',
              'ko-KR',
            ]));

    test('excludePackages', () => expect(CommandConfig.excludePackages, []));
  });

  group('[Models] CommandConfig - custom values', () {
    final logMissing = true;
    final sourceDir = path.normalize('test/source/dir');
    final targetDir = path.normalize('test/target/dir');
    final logDir = path.normalize('$targetDir/logs');
    final outputExtension = 'json';
    final inputExtensions = ['json'];
    final defaultLanguage = 'pl-PL';
    final languages = ['pl-PL', 'en-US'];
    final excludePackages = ['package_to_exclude'];

    setUpAll(() => CommandConfig(
          logMissing: logMissing,
          sourceDir: sourceDir,
          targetDir: targetDir,
          outputExtension: outputExtension,
          inputExtensions: inputExtensions,
          defaultLanguage: defaultLanguage,
          languages: languages,
          excludePackages: excludePackages,
        ));

    test('logMissing', () => expect(CommandConfig.logMissing, logMissing));

    test('logDir', () => expect(CommandConfig.logDir, logDir));

    test('sourceDir', () => expect(CommandConfig.sourceDir, sourceDir));

    test('targetDir', () => expect(CommandConfig.targetDir, targetDir));

    test('outputExtension',
        () => expect(CommandConfig.outputExtension, outputExtension));

    test('inputExtensions',
        () => expect(CommandConfig.inputExtensions, inputExtensions));

    test('defaultLanguage',
        () => expect(CommandConfig.defaultLanguage, defaultLanguage));

    test('languages', () => expect(CommandConfig.languages, languages));

    test('excludePackages',
        () => expect(CommandConfig.excludePackages, excludePackages));
  });
}
