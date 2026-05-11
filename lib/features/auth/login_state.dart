import 'package:equatable/equatable.dart';
import 'package:optom/core/exceptions/exceptions.dart';
import 'package:optom/domain/auth/user_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

// Initial State
class LoginInitial extends LoginState {
  const LoginInitial();
}

// Loading State
class LoginLoading extends LoginState {
  const LoginLoading();
}

// Success State
class LoginSuccess extends LoginState {
  final UserModel user;

  const LoginSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

// Failure State
class LoginFailure extends LoginState {
  final Failure failure;
  final String message;

  const LoginFailure({required this.failure, this.message = ''});

  @override
  List<Object?> get props => [failure, message];
}

// Validation Error State
class LoginValidationError extends LoginState {
  final Map<String, String?> errors;

  const LoginValidationError({required this.errors});

  @override
  List<Object?> get props => [errors];
}

// Password Visibility Toggle State
class PasswordVisibilityToggled extends LoginState {
  final bool obscurePassword;

  const PasswordVisibilityToggled({required this.obscurePassword});

  @override
  List<Object?> get props => [obscurePassword];
}

// Remember Me Toggle State
class RememberMeToggled extends LoginState {
  final bool rememberMe;

  const RememberMeToggled({required this.rememberMe});

  @override
  List<Object?> get props => [rememberMe];
}

// Loading Demo Credentials State
class LoadingDemoCredentials extends LoginState {
  const LoadingDemoCredentials();
}
