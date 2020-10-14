import 'package:test/test.dart';
import 'package:o_i18n_generator/src/data/language_tags.dart';

/// Tests [languageTagsAndNames]

void main() {
  group('[Data] languageTagsAndNames', () {
    test('Length > 0', () {
      expect(languageTagsAndNames?.length, greaterThan(0));
    });

    test('Is a Map', () {
      expect(languageTagsAndNames, isMap);
    });
  });
}
