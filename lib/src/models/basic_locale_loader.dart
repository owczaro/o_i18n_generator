/// A loader containing all language tags, which have translations.
/// It also has a method, which loads translation map for given language tag.
abstract class BasicLocaleLoader {
  /// List of all language tags, which have translations.
  List<String> get languageTags;

  /// Loads translation map for given language tag.
  Map<String, dynamic> loadTranslations(String languageTag);
}
