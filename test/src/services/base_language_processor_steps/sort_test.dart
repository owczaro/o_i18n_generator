import 'package:o_i18n_generator/src/services/base_language_processor_steps/sort.dart';
import 'package:test/test.dart';

/// Tests [SortStep]

Future<void> main() async {
  group('[Services/base_language_processor_steps] SortStep', () {
    test('', () {
      final sortedMap = SortStep({
        'b': 'b',
        'a': 'a',
        'c': 'c',
      }).run();

      expect(sortedMap.keys, orderedEquals(['a', 'b', 'c']));
    });
  });
}
