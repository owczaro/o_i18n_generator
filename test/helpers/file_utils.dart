import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

/// Converts content of file to map
Map<String, dynamic> convertFileToMap(File _file) {
  var _encodedContent = _file.readAsStringSync();
  if (_encodedContent == null || _encodedContent.length < 2) {
    _encodedContent = '{}';
  }
  return jsonDecode(_encodedContent);
}

extension DirectoryCopy on Directory {
  Future<void> copy(String targetPath) async {
    final targetDir = Directory(path.normalize(targetPath));
    await targetDir.create(recursive: true);

    for (var fileEntity in listSync(recursive: true)) {
      if (fileEntity is Directory) {
        await fileEntity.copy(fileEntity.path);
      } else {
        final newFile = File(path
            .normalize('${targetDir.path}/${path.basename(fileEntity.path)}'));
        await newFile.create(recursive: true);
        await newFile.writeAsBytes(await File(fileEntity.path).readAsBytes());
      }
    }
  }
}
