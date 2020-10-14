import '../data/output_extensions.dart';

/// A class which validates output extension.
class OutputExtensionValidator {
  OutputExtensionValidator._();

  /// Check if language tag exist in [outputExtensions]
  /// to prevent processing errors.
  static bool validate(String extension) =>
      extension == null ? false : outputExtensions.contains(extension);
}
