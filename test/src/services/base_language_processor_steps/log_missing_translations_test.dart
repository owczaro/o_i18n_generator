import 'dart:io';

import 'package:o_i18n_generator/src/models/command_config.dart';
import 'package:o_i18n_generator/src/services/base_language_processor_steps/log_missing_translations.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

/// Tests [LogMissingStep]

Future<void> main() async {
  final targetPath = 'test/tmp_dir';
  final defaultLanguageTranslations = {
    'test1': 'Test 1 EN',
    'test2': 'Test 2 EN',
    'test3': 'Test 3 EN',
    'test4': 'Test 4 EN',
  };

  setUpAll(() {
    CommandConfig(
      logMissing: true,
      targetDir: targetPath,
    );
  });

  await tearDownAll(() async => await Directory(targetPath).exists()
      ? await Directory(targetPath).delete(recursive: true)
      : null);

  group('[Services/base_language_processor_steps] LogMissingStep pl-PL', () {
    final plPLTranslations = {
      'test1': 'Test 1 PL',
      'test3': '-->test6',
      'test5': 'Test 5 EN',
    };

    Map<String, dynamic> missingItems;
    File file;

    setUpAll(() {
      missingItems = LogMissingStep(
        languageTag: 'pl-PL',
        defaultLanguageTranslations: defaultLanguageTranslations,
        currentLanguageTranslations: plPLTranslations,
      ).run();

      file = File(path.normalize('${LogMissingStep.targetDir}/pl-PL.json'));
    });

    test('File exists', () async => expect(await file.exists(), true));

    test(
        'Proper content',
        () => expect(missingItems, {
              'test2': 'Test 2 EN',
              'test3': '-->test6',
              'test4': 'Test 4 EN',
            }));
  });

  group('[Services/base_language_processor_steps] LogMissingStep de-DE', () {
    final deDETranslations = {
      'test1': 'Test 1 DE',
      'test2': 'Test 2 DE',
      'test3': 'Test 3 DE',
      'test4': 'Test 4 DE',
    };
    Map<String, dynamic> missingItems;
    File file;
    setUpAll(() {
      missingItems = LogMissingStep(
        languageTag: 'de-DE',
        defaultLanguageTranslations: defaultLanguageTranslations,
        currentLanguageTranslations: deDETranslations,
      ).run();

      file = File(path.normalize('${LogMissingStep.targetDir}/de-DE.json'));
    });

    test('File does not exist', () async => expect(await file.exists(), false));

    test('Empty content', () => expect(missingItems, isEmpty));
  });
}
