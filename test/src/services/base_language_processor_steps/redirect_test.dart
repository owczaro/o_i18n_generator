import 'package:o_i18n_generator/src/services/base_language_processor_steps/redirect.dart';
import 'package:test/test.dart';

/// Tests [RedirectionStep]

Future<void> main() async {
  group('[Services/base_language_processor_steps] RedirectionStep', () {
    test('redirection key does not exist', () {
      final redirectedContent = RedirectionStep({
        'test1': 'Test 1',
        'test2': '-->test4',
        'test5': 'Test 5',
      }).run();

      expect(redirectedContent, redirectedContent);
    });

    test('redirection key does exist', () {
      final redirectedContent = RedirectionStep({
        'test1': 'Test 1',
        'test2': '-->test5',
        'test5': 'Test 5',
      }).run();

      expect(redirectedContent, {
        'test1': 'Test 1',
        'test2': 'Test 5',
        'test5': 'Test 5',
      });
    });

    test('redirection key does exist - nested map from nested map', () {
      final redirectedContent = RedirectionStep({
        'test1': 'Test 1',
        'test2': {
          'test3': 'Test 3',
          'test4': '-->test2.test3',
        },
        'test5': 'Test 5',
      }).run();

      expect(redirectedContent, {
        'test1': 'Test 1',
        'test2': {
          'test3': 'Test 3',
          'test4': 'Test 3',
        },
        'test5': 'Test 5',
      });
    });

    test('redirection key does exist - nested map from main map', () {
      final redirectedContent = RedirectionStep({
        'test1': 'Test 1',
        'test2': {
          'test3': 'Test 3',
          'test4': '-->test1',
        },
        'test5': 'Test 5',
      }).run();

      expect(redirectedContent, {
        'test1': 'Test 1',
        'test2': {
          'test3': 'Test 3',
          'test4': 'Test 1',
        },
        'test5': 'Test 5',
      });
    });

    test('redirection loop', () {
      final redirectedContent = RedirectionStep({
        'test1': 'Test 1',
        'test2': {
          'test3': 'Test 3',
          'test4': '-->test2',
        },
        'test5': 'Test 5',
      }).run();

      expect(redirectedContent, {
        'test1': 'Test 1',
        'test2': {
          'test3': 'Test 3',
          'test4': '-->test2',
        },
        'test5': 'Test 5',
      });
    });
  });
}
