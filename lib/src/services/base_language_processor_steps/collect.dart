import 'dart:convert';

import 'package:dependency_visitor/dependency_visitor.dart';
import 'package:merge_map/merge_map.dart';
import 'package:path/path.dart' as path;

import '../../models/command_config.dart';

/// A step of searching language files
/// in [CommandConfig.sourceDir] and [sourceDir2]
/// in all dependant packages (except [CommandConfig.excludePackages]).
class CollectStep {
  /// A language tag to process.
  final String languageTag;

  /// Second directory, where we try to find language file.
  static const sourceDir2 = 'assets/i18n';

  /// Create an instance of [CollectStep]
  const CollectStep(this.languageTag);

  String get _firstSourcePath =>
      path.normalize('${CommandConfig.sourceDir}/$languageTag');

  String get _secondSourcePath => path.normalize('$sourceDir2/$languageTag');

  /// Runs the process. Returns merged translations - [translations].
  Future<Map<String, dynamic>> run() async {
    var translations = <String, dynamic>{};
    for (var extension in CommandConfig.inputExtensions) {
      await DependencyVisitor(filePaths: [
        '$_firstSourcePath.$extension',
        '$_secondSourcePath.$extension'
      ]).run().forEach((dependencyFile) {
        if (CommandConfig.excludePackages
            .contains(dependencyFile.packageName)) {
          return null;
        }
        final newContent =
            jsonDecode(dependencyFile.content) as Map<String, dynamic>;
        translations = mergeMap([translations, newContent]);
      });
    }

    return translations;
  }
}
