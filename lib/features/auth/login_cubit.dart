import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:optom/core/exceptions/exceptions.dart';
import 'package:optom/domain/auth/auth_repository.dart';
import 'login_state.dart';

@Injectable()
class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginInitial());

  // Form field controllers
  String _username = '';
  String _password = '';
  bool _rememberMe = false;
  bool _obscurePassword = true;

  // Getters
  String get username => _username;
  String get password => _password;
  bool get rememberMe => _rememberMe;
  bool get obscurePassword => _obscurePassword;

  // Username changed
  void usernameChanged(String value) {
    _username = value;
    // Clear validation errors when user starts typing
    if (state is LoginValidationError) {
      emit(const LoginInitial());
    }
  }

  // Password changed
  void passwordChanged(String value) {
    _password = value;
    if (state is LoginValidationError) {
      emit(const LoginInitial());
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    emit(PasswordVisibilityToggled(obscurePassword: _obscurePassword));
  }

  // Toggle remember me
  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    emit(RememberMeToggled(rememberMe: _rememberMe));
  }

  // Login method
  Future<void> login() async {
    final validationErrors = _validateForm();
    if (validationErrors.isNotEmpty) {
      emit(LoginValidationError(errors: validationErrors));
      return;
    }

    emit(const LoginLoading());

    final result = await _authRepository.login(
      username: _username.trim(),
      password: _password,
    );

    result.fold(
      (failure) => emit(
        LoginFailure(failure: failure, message: _getErrorMessage(failure)),
      ),
      (value) => emit(LoginSuccess(user: value)),
    );
  }

  Map<String, String?> _validateForm() {
    final Map<String, String?> errors = {};

    // Validate username
    if (_username.isEmpty) {
      errors['username'] = 'Username is required';
    } else if (_username.length < 3) {
      errors['username'] = 'Username must be at least 3 characters';
    }

    // Validate password
    if (_password.isEmpty) {
      errors['password'] = 'Password is required';
    } else if (_password.length < 6) {
      errors['password'] = 'Password must be at least 6 characters';
    }

    return errors;
  }

  String _getErrorMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'Network error: ${failure.message}';
    } else if (failure is AuthFailure) {
      return 'Authentication failed: ${failure.message}';
    } else if (failure is ValidationFailure) {
      return 'Validation error: ${failure.message}';
    } else if (failure is ServerFailure) {
      return 'Server error: ${failure.message}';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  void reset() {
    _username = '';
    _password = '';
    _rememberMe = false;
    _obscurePassword = true;
    emit(const LoginInitial());
  }
}
