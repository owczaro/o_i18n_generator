import 'dart:io';

import 'package:o_i18n_generator/src/utls/file_utils.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  final targetPath = 'test/tmp_dir';

  await tearDownAll(() async => await Directory(targetPath).exists()
      ? await Directory(targetPath).delete(recursive: true)
      : null);

  group('[Utils] openFile', () {
    File file;
    test('openFile', () {
      file = openFile(path.normalize('$targetPath/test.test'));
      expect(file.existsSync(), true);
    });

    test('saveMapToFile', () {
      saveMapToFile({'test': 'Test'}, file);
      expect(file.readAsBytesSync(), hasLength(greaterThan(0)));
    });
    test('deleteDir', () async {
      await deleteDir(path.normalize(targetPath));
      expect(Directory(targetPath).existsSync(), false);
    });
  });
}
