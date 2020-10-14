import 'dart:io';

import 'package:o_i18n_generator/src/converters/map_to_json.dart';
import 'package:o_i18n_generator/src/models/command_config.dart';
import 'package:test/test.dart';

import '../../helpers/file_utils.dart';

/// Tests [MapToJson]

Future<void> main() async {
  final targetPath = 'test/tmp_dir';
  final translations = {
    'en-US': {'test': 'Test EN'},
    'pl-PL': {'test': 'Test PL'},
    'de-DE': {'test': 'Test DE'},
  };

  await setUpAll(() async {
    CommandConfig(
      targetDir: targetPath,
    );
  });

  await tearDownAll(() async => await Directory(targetPath).exists()
      ? await Directory(targetPath).delete(recursive: true)
      : null);

  for (var tag in translations.keys) {
    group('[Converters] MapToJson $tag', () {
      File file;

      setUpAll(() {
        MapToJson(
          languageTag: tag,
          translations: translations[tag],
        );
        file = File('$targetPath/$tag.g.json');
      });

      test('File exists', () async => expect(await file.exists(), true));

      test('Valid content',
          () => expect(convertFileToMap(file), translations[tag]));
    });
  }
}
