import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optom/core/di/service_locator.dart';
import 'package:optom/features/auth/login_cubit.dart';
import 'package:optom/features/auth/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<LoginCubit>()..reset(),
      child: Scaffold(
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            final cubit = context.read<LoginCubit>();
            final isLoading = state is LoginLoading;
            final error = state is LoginFailure ? state.message : null;
            final validationErrors = state is LoginValidationError ? state.errors : {};

            // Handle success
            if (state is LoginSuccess) {
              Future.microtask(() => Navigator.pushReplacementNamed(context, '/home'));
            }

            // Handle error
            if (error != null) {
              Future.microtask(() {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error), backgroundColor: Colors.red),
                );
                cubit.reset();
              });
            }

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.login, size: 80, color: Colors.blue),
                    const SizedBox(height: 20),
                    const Text('Login', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 40),

                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        border: const OutlineInputBorder(),
                        errorText: validationErrors['username'],
                      ),
                      onChanged: cubit.phoneChanged,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        errorText: validationErrors['password'],
                      ),
                      obscureText: true,
                      onChanged: cubit.passwordChanged,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : cubit.login,
                        child: isLoading ? const CircularProgressIndicator() : const Text('Sign In'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}