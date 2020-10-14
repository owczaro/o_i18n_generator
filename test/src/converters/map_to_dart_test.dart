import 'dart:io';

import 'package:o_i18n_generator/src/converters/map_to_dart.dart';
import 'package:o_i18n_generator/src/models/command_config.dart';
import 'package:test/test.dart';

/// Tests [MapToDart]

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
    group('[Converters] MapToDart $tag', () {
      File file;

      setUpAll(() {
        MapToDart(
          languageTag: tag,
          translations: translations[tag],
        );
        file = File('$targetPath/$tag.g.dart');
      });

      test('File exists', () async => expect(await file.exists(), true));

      test(
          'Content not empty',
          () async =>
              expect(await file.readAsBytes(), hasLength(greaterThan(0))));
    });
  }
}
