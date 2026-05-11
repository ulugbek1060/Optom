import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:optom/core/exceptions/exceptions.dart';
import 'package:optom/data/auth/login_response.dart';

@injectable
class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/api/auth/login',
        data: {'username': username, 'password': password},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw AuthException(
          message: 'Login failed with status code: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  AuthException _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;

      String message = 'Login failed';
      if (data != null && data is Map) {
        message = data['message'] ?? data['error'] ?? 'Login failed';
      } else if (statusCode == 401) {
        message = 'Invalid username or password';
      } else if (statusCode == 422) {
        message = 'Validation error. Please check your input.';
      }
      return AuthException(message: message, statusCode: statusCode, error: e);
    } else if (e.type == DioExceptionType.connectionTimeout) {
      return AuthException(
        message: 'Connection timeout. Please check your internet connection.',
        error: e,
      );
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return AuthException(
        message: 'Receive timeout. Server is not responding.',
        error: e,
      );
    } else {
      return AuthException(message: 'Network error: ${e.message}', error: e);
    }
  }
}
