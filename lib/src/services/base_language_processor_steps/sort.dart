import 'package:deep_collection/deep_collection.dart';

/// A step of sorting translations by values.
class SortStep {
  /// A map of translations of currently processing language.
  final Map<String, dynamic> currentLanguageTranslations;

  /// Creates an instance of [SortStep]
  SortStep(this.currentLanguageTranslations);

  /// Runs the process.
  Map<String, dynamic> run() => currentLanguageTranslations.deepSortByValue();
}
