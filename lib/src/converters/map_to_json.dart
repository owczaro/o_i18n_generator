import 'dart:io';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

import '../../o_i18n_generator.dart';
import '../models/command_config.dart';
import '../utls/file_utils.dart';

/// A converter, which transforms a map of translations
/// to `.g.json` file. It helps to statically apply translations.
class MapToJson {
  /// A language tag to process.
  final String languageTag;

  /// A map containing translations.
  final Map<String, dynamic> translations;

  /// Creates an instance of [MapToDart]
  MapToJson({
    @required this.languageTag,
    @required this.translations,
  }) : assert(languageTagsAndNames.keys.contains(languageTag)) {
    saveMapToFile(translations, _outputFile);
  }

  File get _outputFile => openFile(
      path.normalize('${CommandConfig.targetDir}/$languageTag.g.json'));
}
