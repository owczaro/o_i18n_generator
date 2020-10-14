import 'dart:io';

import 'package:o_i18n_generator/src/models/command_config.dart';
import 'package:o_i18n_generator/src/services/base_language_processor_steps/collect.dart';
import 'package:test/test.dart';

import '../../../helpers/file_utils.dart';

/// Tests [CollectStep]

Future<void> main() async {
  final sourcePath = 'test/source_test_files/json';

  for (var tag in ['en-US', 'pl-PL', 'de-DE']) {
    group('[Services/base_language_processor_steps] CollectStep ($tag)', () {
      Map<String, dynamic> translations;

      setUpAll(() async {
        CommandConfig(
          sourceDir: sourcePath,
        );

        translations = await CollectStep(tag).run();
      });

      test('Content not empty',
          () async => expect(translations, hasLength(greaterThan(0))));

      test(
          'Proper content',
          () => expect(
                translations,
                convertFileToMap(File('$sourcePath/$tag.json')),
              ));
    });

    group(
        '[Services/base_language_processor_steps] CollectStep ($tag) '
        '- exclude root lib', () {
      Map<String, dynamic> translations;
      setUpAll(() async {
        CommandConfig(
          sourceDir: sourcePath,
          excludePackages: ['o_i18n_generator'],
        );

        translations = await CollectStep(tag).run();
      });

      test('No translations', () async => expect(translations, isEmpty));
    });
  }
}
