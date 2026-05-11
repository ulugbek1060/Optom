import 'package:dartz/dartz.dart';
import 'package:optom/core/exceptions/exceptions.dart';
import 'package:optom/domain/auth/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> login({required String phone, required String password});
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserModel>> getCurrentUser();
  Future<Either<Failure, bool>> isAuthenticated();
  Future<Either<Failure, String>> getAccessToken();
}
