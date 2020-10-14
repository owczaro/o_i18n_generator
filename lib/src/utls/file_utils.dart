import 'dart:convert';
import 'dart:io';

/// Saves map to file
void saveMapToFile(Map<String, dynamic> _map, File _file) {
  final encoder = JsonEncoder.withIndent('  ');
  final _encodedOutputContent = encoder.convert(_map);
  _file.writeAsStringSync(_encodedOutputContent);
}

/// Deletes directory
Future<void> deleteDir(String dirName) async {
  final dir = Directory(dirName);
  if (await dir.exists()) {
    await dir.delete(recursive: true);
  }
}

/// Opens file and create if doesn't exist
File openFile(String _path) {
  var _file = File(_path);
  if (!_file.existsSync()) {
    _file.createSync(recursive: true);
  }
  return _file;
}
