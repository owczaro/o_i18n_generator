import 'package:o_i18n_generator/src/converters/language_tag_to_var.dart';
import 'package:test/test.dart';

/// Tests [LanguageTagToVar]

Future<void> main() async {
  group('[Converters] LanguageTagToVar', () {
    test('en-US',
        () => expect(LanguageTagToVar.convert('en-US'), equals('enUS')));
    test('pl-PL',
        () => expect(LanguageTagToVar.convert('pl-PL'), equals('plPL')));
    test('de-DE',
        () => expect(LanguageTagToVar.convert('de-DE'), equals('deDE')));
  });
}
