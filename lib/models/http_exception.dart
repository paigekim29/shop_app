class HttpException implements Exception {
  // implements uses all functions under class Exception
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
    // return super.toString(); // Instance of HttpException
  }
}
