import 'dart:io';
import 'package:o_i18n_generator/src/services/default_language_processor.dart';
import 'package:path/path.dart' as path;

import 'package:o_i18n_generator/src/models/command_config.dart';
import 'package:o_i18n_generator/src/services/language_processor.dart';
import 'package:test/test.dart';

/// Tests [LanguageProcessor]
Future<void> main() async {
  final sourcePath = 'test/source_test_files/json';
  final targetPath = 'test/tmp_dir';

  setUpAll(() => CommandConfig(
        sourceDir: sourcePath,
        targetDir: targetPath,
        logMissing: true,
      ));

  await tearDownAll(() async => await Directory(targetPath).exists()
      ? await Directory(targetPath).delete(recursive: true)
      : null);

  group('[Services] LanguageProcessor', () {
    LanguageProcessor processor;
    setUpAll(() async {
      var defaultLanguageProcessor = DefaultLanguageProcessor();
      await defaultLanguageProcessor.run();
      processor = LanguageProcessor(
        'pl-PL',
        defaultLanguageProcessor.translations,
      );
      await processor.run();
    });

    test(
        'Test currentLanguageTag field',
        () => expect(
              processor.currentLanguageTag,
              'pl-PL',
            ));

    test('Translation is not empty',
        () => expect(processor.translations, hasLength(greaterThan(0))));

    test(
        'File exists',
        () => expect(
              File(path.normalize('${CommandConfig.targetDir}/pl-PL.g.dart'))
                  .existsSync(),
              true,
            ));
  });
}
