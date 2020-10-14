import '../data/input_extensions.dart';

/// A class which filters input extensions.
class InputExtensionsFilter {
  InputExtensionsFilter._();

  /// Removes language tags which does not exist in [inputExtensions]
  /// to prevent processing errors.
  static List<String> filter(List<String> extensions) => extensions != null
      ? (extensions..removeWhere((ext) => !inputExtensions.contains(ext)))
      : null;
}
