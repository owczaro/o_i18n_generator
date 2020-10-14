import 'package:o_i18n_generator/src/validators/output_extension.dart';
import 'package:test/test.dart';

/// Tests [OutputExtensionValidator]

Future<void> main() async {
  group('[Validators] OutputExtensionValidator.validate', () {
    test('Valid extension - json',
        () => expect(OutputExtensionValidator.validate('json'), true));

    test('Valid extension - dart',
        () => expect(OutputExtensionValidator.validate('dart'), true));

    test('Invalid extension - test',
        () => expect(OutputExtensionValidator.validate('test'), false));
  });
}
