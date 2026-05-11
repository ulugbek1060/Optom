
// Custom Exception
import 'package:equatable/equatable.dart';

class AuthException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic error;

  AuthException({required this.message, this.statusCode, this.error});

  @override
  String toString() {
    return 'AuthException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
  }
}

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;
  const Failure({required this.message, this.statusCode});
  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.statusCode});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}
