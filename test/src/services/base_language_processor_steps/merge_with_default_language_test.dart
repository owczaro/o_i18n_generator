import 'package:o_i18n_generator/src/services/base_language_processor_steps/merge_with_default_language.dart';
import 'package:test/test.dart';

/// Tests [MergeWithDefaultLanguageStep]

Future<void> main() async {
  final defaultLanguageTranslations = {
    'test1': 'Test 1 EN',
    'test2': 'Test 2 EN',
    'test3': 'Test 3 EN',
    'test4': 'Test 4 EN',
  };
  group(
      '[Services/base_language_processor_steps] MergeWithDefaultLanguageStep pl-PL',
      () {
    final plPLTranslations = {
      'test1': 'Test 1 PL',
      'test3': '-->test6',
      'test5': 'Test 5 EN',
    };
    Map<String, dynamic> mergedTranslations;

    setUpAll(() {
      mergedTranslations = MergeWithDefaultLanguageStep(
        defaultLanguageTranslations: defaultLanguageTranslations,
        currentLanguageTranslations: plPLTranslations,
      ).run();
    });

    test(
        'Proper content',
        () => expect(mergedTranslations, {
              'test1': 'Test 1 PL',
              'test2': 'Test 2 EN',
              'test3': '-->test6',
              'test4': 'Test 4 EN',
              'test5': 'Test 5 EN',
            }));
  });

  group(
      '[Services/base_language_processor_steps] MergeWithDefaultLanguageStep en-US',
      () {
    test(
        'Proper content',
        () => expect(
            MergeWithDefaultLanguageStep(
              defaultLanguageTranslations: defaultLanguageTranslations,
              currentLanguageTranslations: defaultLanguageTranslations,
            ).run(),
            defaultLanguageTranslations));
  });
}
