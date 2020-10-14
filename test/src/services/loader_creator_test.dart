import 'dart:io';

import 'package:o_i18n_generator/src/models/command_config.dart';
import 'package:o_i18n_generator/src/services/loader_creator.dart';
import 'package:test/test.dart';

/// Tests [LoaderCreator]

Future<void> main() async {
  final targetPath = 'test/tmp_dir';
  File file;

  await setUpAll(() async {
    CommandConfig(
      logMissing: true,
      targetDir: targetPath,
    );

    LoaderCreator(['pl-PL', 'de-DE']);
  });

  await tearDownAll(() async => await Directory(targetPath).exists()
      ? await Directory(targetPath).delete(recursive: true)
      : null);

  group('[Services] LoaderCreator', () {
    setUpAll(() {
      file = File('$targetPath/locale_loader.g.dart');
    });

    test('File exists', () async => expect(await file.exists(), true));

    test(
        'Proper content',
        () async => expect(await file.readAsBytes(),
            await File('test/source_test_files/locale_loader').readAsBytes()));
  });
}
