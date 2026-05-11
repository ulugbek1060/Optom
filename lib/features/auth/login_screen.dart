import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optom/core/di/service_locator.dart';
import 'package:optom/core/exceptions/exceptions.dart';
import 'package:optom/features/auth/login_cubit.dart';
import 'package:optom/features/auth/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => locator<LoginCubit>(),
    child: const LoginView(),
  );
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // Navigate to home screen
            _onLoginSuccess(context, state);
          } else if (state is LoginFailure) {
            // Show error dialog
            _onLoginFailure(context, state);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade900,
                Colors.blue.shade600,
                Colors.blue.shade400,
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildLoginForm(),
                  const SizedBox(height: 20),
                  _buildDemoButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.safety_check,
            size: 60,
            color: Colors.blue.shade900,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue',
          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9)),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) {
            // Rebuild only when these states change
            return current is LoginInitial ||
                current is LoginLoading ||
                current is LoginValidationError ||
                current is PasswordVisibilityToggled ||
                current is RememberMeToggled;
          },
          builder: (context, state) {
            final cubit = context.read<LoginCubit>();

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Username Field
                _buildUsernameField(cubit, state, context),
                const SizedBox(height: 16),

                // Password Field
                _buildPasswordField(cubit, state),
                const SizedBox(height: 8),

                // Remember Me & Forgot Password
                _buildRememberMeAndForgotPassword(context, cubit, state),
                const SizedBox(height: 24),

                // Login Button
                _buildLoginButton(cubit, state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildUsernameField(
    LoginCubit cubit,
    LoginState state,
    BuildContext context,
  ) {
    String? error;
    if (state is LoginValidationError) {
      error = state.errors['username'];
    }

    return TextFormField(
      initialValue: cubit.username,
      decoration: InputDecoration(
        labelText: 'Username / Email / Phone',
        hintText: 'Enter your username',
        prefixIcon: const Icon(Icons.person_outline),
        errorText: error,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
      onChanged: cubit.usernameChanged,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
    );
  }

  Widget _buildPasswordField(LoginCubit cubit, LoginState state) {
    String? error;
    if (state is LoginValidationError) {
      error = state.errors['password'];
    }

    final obscurePassword = state is PasswordVisibilityToggled
        ? state.obscurePassword
        : cubit.obscurePassword;

    return TextFormField(
      initialValue: cubit.password,
      obscureText: obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: cubit.togglePasswordVisibility,
        ),
        errorText: error,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
      onChanged: cubit.passwordChanged,
      onFieldSubmitted: (_) => cubit.login(),
    );
  }

  Widget _buildRememberMeAndForgotPassword(
    BuildContext context,
    LoginCubit cubit,
    LoginState state,
  ) {
    final rememberMe = state is RememberMeToggled
        ? state.rememberMe
        : cubit.rememberMe;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: (_) => cubit.toggleRememberMe(),
              activeColor: Colors.blue.shade700,
            ),
            const Text('Remember me'),
          ],
        ),
        TextButton(
          onPressed: () => _showForgotPasswordDialog(context),
          child: const Text('Forgot Password?'),
        ),
      ],
    );
  }

  Widget _buildLoginButton(LoginCubit cubit, LoginState state) {
    final isLoading = state is LoginLoading;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : cubit.login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Sign In',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Widget _buildDemoButton(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        final isLoadingDemo = state is LoadingDemoCredentials;

        if (isLoadingDemo) {
          return const CircularProgressIndicator();
        }

        return OutlinedButton.icon(
          onPressed: isLoading
              ? null
              : () => {},
          icon: const Icon(Icons.science_outlined),
          label: const Text('Use Demo Credentials'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }

  void _onLoginSuccess(BuildContext context, LoginSuccess state) {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Welcome back, ${state.user.name}!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );

    // Navigate to home screen
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _onLoginFailure(BuildContext context, LoginFailure state) {
    String title = 'Login Failed';
    String message = state.message;

    if (state.failure is NetworkFailure) {
      title = 'Network Error';
    } else if (state.failure is AuthFailure) {
      title = 'Authentication Failed';
    } else if (state.failure is ServerFailure) {
      title = 'Server Error';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 28),
            const SizedBox(width: 12),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_reset, size: 48, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'Enter your email address to receive password reset instructions.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password reset link sent to your email'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
            ),
            child: const Text('Send Reset Link'),
          ),
        ],
      ),
    );
  }
}
