import 'package:test/test.dart';
import 'package:o_i18n_generator/src/data/output_extensions.dart';

/// Tests [outputExtensions]

void main() {
  group('[Data] outputExtensions', () {
    test('Length > 0', () {
      expect(outputExtensions?.length, greaterThan(0));
    });

    test('Is a List', () {
      expect(outputExtensions, isList);
    });
  });
}
