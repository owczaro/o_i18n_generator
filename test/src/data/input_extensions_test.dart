import 'package:test/test.dart';
import 'package:o_i18n_generator/src/data/input_extensions.dart';

/// Tests [inputExtensions]

void main() {
  group('[Data] inputExtensions', () {
    test('Length > 0', () {
      expect(inputExtensions?.length, greaterThan(0));
    });

    test('Is a List', () {
      expect(inputExtensions, isList);
    });
  });
}
