import 'package:o_i18n_generator/src/services/base_language_processor.dart';
import 'package:test/test.dart';

/// Tests [BaseLanguageProcessor]
class BaseLanguageProcessorTest extends BaseLanguageProcessor {
  BaseLanguageProcessorTest(String currentLanguageTag)
      : super(currentLanguageTag);

  /// Test implementation of method.
  @override
  Future<void> run() async {}
}

Future<void> main() async {
  group('[Services] BaseLanguageProcessor', () {
    test(
        'Test class is an instance of BaseLanguageProcessor',
        () => expect(
              BaseLanguageProcessorTest('test'),
              isA<BaseLanguageProcessor>(),
            ));
  });
}
