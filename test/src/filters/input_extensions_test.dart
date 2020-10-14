import 'package:o_i18n_generator/src/filters/input_extensions.dart';
import 'package:test/test.dart';

/// Tests [InputExtensionsFilter]

Future<void> main() async {
  group('[Filters] InputExtensionsFilter.filter', () {
    test('Valid extension',
        () => expect(InputExtensionsFilter.filter(['json']), equals(['json'])));

    test(
        'Valid extension and one invalid',
        () => expect(
            InputExtensionsFilter.filter(['json', 'dart']), equals(['json'])));

    test('Invalid extension',
        () => expect(InputExtensionsFilter.filter(['dart']), equals([])));
  });
}
