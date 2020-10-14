import 'package:o_i18n_generator/src/models/basic_locale_loader.dart';
import 'package:test/test.dart';

/// Tests [BasicLocaleLoader]

class LocaleLoader extends BasicLocaleLoader {
  List<String> get languageTags => ['pl-PL', 'en-US'];
  Map<String, dynamic> loadTranslations(String languageTag) {
    switch (languageTag) {
      case 'pl-PL':
        return {'language': 'pl'};
      default:
        return {'language': 'en'};
    }
  }
}

Future<void> main() async {
  final loader = LocaleLoader();
  group('[Models] BasicLocaleLoader', () {
    test('Get languageTags',
        () => expect(loader.languageTags, equals(['pl-PL', 'en-US'])));

    test(
        'Get loadTranslations(pl-PL)',
        () => expect(
            loader.loadTranslations('pl-PL'), equals({'language': 'pl'})));

    test(
        'Get loadTranslations(en-US)',
        () => expect(
            loader.loadTranslations('en-US'), equals({'language': 'en'})));
  });
}
