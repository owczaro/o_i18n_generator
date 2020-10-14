import 'dart:io';

import 'package:o_i18n_generator/src/models/command_config.dart';
import 'package:o_i18n_generator/src/o_i18n_generator_command.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;
import '../helpers/file_utils.dart';

/// Tests [OI18nGeneratorCommand]
Future<void> main() async {
  final sourceDir = path.normalize('test/test_source');
  final targetDir = path.normalize('test/test_target');
  final outputExtension = 'json';
  final defaultLanguage = 'en-US';

  await setUpAll(() async {
    await Directory(path.normalize('test/source_test_files/json'))
        .copy(sourceDir);
    CommandConfig(
      sourceDir: sourceDir,
      targetDir: targetDir,
      outputExtension: outputExtension,
      defaultLanguage: defaultLanguage,
    );

    await OI18nGeneratorCommand().run();
  });

  await tearDownAll(() async {
    await Directory(sourceDir).exists()
        ? await Directory(sourceDir).delete(recursive: true)
        : null;
    await Directory(targetDir).exists()
        ? await Directory(targetDir).delete(recursive: true)
        : null;
  });

  group('OI18nGeneratorCommand', () {
    test('test default file', () {
      final generatedFile = File(path.normalize(
          '${CommandConfig.targetDir}/${CommandConfig.defaultLanguage}.g.$outputExtension'));
      expect(convertFileToMap(generatedFile), {
        "test": "Test EN",
        "test2": "Test 2 EN",
        "test3": "Test 3 EN",
        "test5": "Test 5 EN",
      });
    });

    test('test pl-PL file', () {
      final generatedFile = File(path
          .normalize('${CommandConfig.targetDir}/pl-PL.g.$outputExtension'));
      expect(convertFileToMap(generatedFile), {
        "test": "Test PL",
        "test2": "Test 2 EN",
        "test3": "-->test4",
        "test5": "Test 5 EN",
      });
    });

    test('test de-DE file', () {
      final generatedFile = File(path
          .normalize('${CommandConfig.targetDir}/de-DE.g.$outputExtension'));
      expect(convertFileToMap(generatedFile), {
        "test": "Test DE",
        "test2": "Test DE",
        "test3": "Test 3 DE",
        "test5": "Test 5 DE",
      });
    });
  });
}
