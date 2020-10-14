/// This exception can be thrown only in [DefaultLanguageProcessor]
class DefaultLanguageException implements Exception {
  /// A cause of this exception.
  String message;

  /// Creates an instance of [DefaultLanguageException]
  DefaultLanguageException(this.message);
}