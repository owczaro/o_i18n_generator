import 'package:o_i18n_generator/src/data/language_tags.dart';
import 'package:o_i18n_generator/src/filters/language_tags.dart';
import 'package:o_i18n_generator/src/models/command_config.dart';
import 'package:test/test.dart';

/// Tests [LanguageTagsFilter]

Future<void> main() async {
  group('[Filters] LanguageTagsFilter.filter', () {
    test(
        'Valid language tags',
        () => expect(LanguageTagsFilter.filter(['en-US', 'pl-PL']),
            equals(['en-US', 'pl-PL'])));

    test(
        '1 valid and 1 invalid language tag',
        () => expect(LanguageTagsFilter.filter(['en-US', 'plx-PLx']),
            equals(['en-US'])));

    test('Invalid language tag',
        () => expect(LanguageTagsFilter.filter(['plx-PLx']), equals([])));

    test(
        'All available language tags',
        () => expect(LanguageTagsFilter.filter([...languageTagsAndNames.keys]),
            equals(languageTagsAndNames.keys)));
  });

  group('[Filters] LanguageTagsFilter.removeDefaultLanguage (en-US)', () {
    setUpAll(() => CommandConfig(
          defaultLanguage: 'en-US',
        ));
    test(
        'Default language tag exists',
        () => expect(
            LanguageTagsFilter.removeDefaultLanguage(['en-US', 'pl-PL']),
            equals(['pl-PL'])));

    test(
        'Default language tag does not exist',
        () => expect(LanguageTagsFilter.removeDefaultLanguage(['pl-PL']),
            equals(['pl-PL'])));

    test(
        'Only default language tag exists',
        () => expect(
            LanguageTagsFilter.removeDefaultLanguage(['en-US']), equals([])));
  });

  group('[Filters] LanguageTagsFilter.removeDefaultLanguage (pl-PL)', () {
    setUpAll(() => CommandConfig(
          defaultLanguage: 'pl-PL',
        ));
    test(
        'Default language tag exists',
        () => expect(
            LanguageTagsFilter.removeDefaultLanguage(['en-US', 'pl-PL']),
            equals(['en-US'])));

    test(
        'Default language tag does not exist',
        () => expect(LanguageTagsFilter.removeDefaultLanguage(['en-US']),
            equals(['en-US'])));

    test(
        'Only default language tag exists',
        () => expect(
            LanguageTagsFilter.removeDefaultLanguage(['pl-PL']), equals([])));
  });
}
