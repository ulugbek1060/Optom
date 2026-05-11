import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:optom/core/exceptions/exceptions.dart';
import 'package:optom/data/auth/auth_local_data_source.dart';
import 'package:optom/data/auth/auth_remote_data_source.dart';
import 'package:optom/domain/auth/auth_repository.dart';
import 'package:optom/domain/auth/user_model.dart';


@Injectable(as: AuthRepository)
class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepoImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, UserModel>> login({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      return Left(
        ValidationFailure(message: 'Username and password cannot be empty'),
      );
    }
    try {
      final response = await remoteDataSource.login(
        username: username,
        password: password,
      );

      // Save to local storage
      await localDataSource.saveToken(response.accessToken);
      await localDataSource.saveUser(response.user.toJson().toString());

      // Convert to domain entity
      final loginResponse = UserModel(
        id: response.user.id,
        name: response.user.name,
        phone: response.user.phone,
        role: response.user.role,
        status: response.user.status,
      );

      return Right(loginResponse);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(
        ServerFailure(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearAuthData();
      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to clear auth data: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final userJson = localDataSource.getUser();
      if (userJson == null) {
        return Left(CacheFailure(message: 'No user data found'));
      }
      // Parse user JSON (simplified - use proper JSON decoding)
      // In real implementation, you'd parse the JSON properly
      return Right(
        UserModel(id: '', name: '', phone: '', role: '', status: ''),
      );
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to get user data: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final hasToken = localDataSource.hasToken();
      final token = localDataSource.getToken();

      // You can add token validation logic here
      return Right(hasToken && token != null && token.isNotEmpty);
    } catch (e) {
      return Left(
        CacheFailure(
          message: 'Failed to check authentication status: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> getAccessToken() async {
    try {
      final token = localDataSource.getToken();
      if (token == null || token.isEmpty) {
        return Left(CacheFailure(message: 'No access token found'));
      }
      return Right(token);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to get access token: ${e.toString()}'),
      );
    }
  }

  Failure _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response?.statusCode;
      final data = error.response?.data;

      String message = 'Login failed';
      if (data != null && data is Map) {
        message = data['message'] ?? data['error'] ?? 'Login failed';
      }

      if (statusCode == 401) {
        return AuthFailure(
          message: 'Invalid username or password',
          statusCode: statusCode,
        );
      } else if (statusCode == 422) {
        return ValidationFailure(message: message);
      } else if (statusCode != null && statusCode >= 500) {
        return ServerFailure(
          message: 'Server error. Please try again later.',
          statusCode: statusCode,
        );
      }

      return AuthFailure(message: message, statusCode: statusCode);
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return NetworkFailure(
        message: 'Connection timeout. Please check your internet connection.',
      );
    } else {
      return NetworkFailure(message: 'Network error: ${error.message}');
    }
  }
}
