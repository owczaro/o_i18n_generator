/// A step of finding [redirectionSign] and replacing values with proper ones.
class RedirectionStep {
  /// A map of translations of currently processing language.
  final Map<String, dynamic> currentLanguageTranslations;

  /// Max amount of redirection for a translation key
  static const maxRedirects = 255;

  /// A sign to separate keys in redirection string.
  static const keySeparator = '.';

  /// It tells whether the value is a redirection or not.
  static const redirectionSign = '-->';

  /// Creates an instance of [RedirectionStep]
  RedirectionStep(this.currentLanguageTranslations);

  /// Runs the process.
  Map<String, dynamic> run() => _redirectTranslations(
        currentLanguageTranslations,
        currentLanguageTranslations,
      );

  /// Redirects values in [sourceMap]
  Map<String, dynamic> _redirectTranslations(
    Map<String, dynamic> subMap,
    Map<String, dynamic> sourceMap,
  ) {
    subMap.forEach((key, value) {
      if (value is Map) {
        subMap[key] =
            _redirectTranslations(value.cast<String, dynamic>(), sourceMap);
      } else if (value is String && value.contains(redirectionSign)) {
        var newValue = value;
        var i = 0;
        do {
          i++;
          var _searchKey = newValue.replaceFirst(redirectionSign, '');
          newValue = _searchByKeyPath(sourceMap, _searchKey);
        } while (newValue != null &&
            newValue.contains(redirectionSign) &&
            i < maxRedirects);
        subMap[key] = newValue ?? subMap[key];
      }
    });

    return subMap;
  }

  /// Search value in [map] under [keyPath]
  String _searchByKeyPath(Map<String, dynamic> map, String keyPath) {
    var explodedKey = keyPath.split(keySeparator);
    final keyPart = explodedKey.first;

    if (!map.containsKey(keyPart)) {
      return null;
    }
    if (map[keyPart].runtimeType != String) {
      explodedKey.removeAt(0);
      return _searchByKeyPath(map[keyPart], explodedKey.join(keySeparator));
    }
    return map[keyPart];
  }
}
