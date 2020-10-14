import 'package:o_i18n_generator/src/models/default_language_exception.dart';
import 'package:test/test.dart';

/// Tests [DefaultLanguageException]

void testThrower() => throw DefaultLanguageException('Test');

Future<void> main() async {
  group('[Models] DefaultLanguageException', () {
    test('Throws an error',
        () => expect(testThrower, throwsA(isA<DefaultLanguageException>())));
  });
}
