

abstract class Failure {}

class NetworkFailure extends Failure {}

class ServerFailure extends Failure {}

class UnknownFailure extends Failure {}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = "No internet connection"]);
}