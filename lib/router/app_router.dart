import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optom/core/di/service_locator.dart';
import 'package:optom/features/auth/login_screen.dart';
import 'package:optom/features/home/home_screen.dart';
import 'package:optom/features/products/craete_product_screen.dart';
import 'package:optom/features/products/product_screen.dart';
import 'package:optom/features/shell/shell_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
  static const login = '/login';
  static const home = '/home';
  static const products = '/products';
  static const createProduct = '/create-product';
}

// Redirect logic with proper error handling
FutureOr<String?> _redirectLogic(BuildContext context, GoRouterState state) {
  try {
    // Check if dependencies are initialized
    if (!locator.isRegistered<SharedPreferences>()) {
      debugPrint('SharedPreferences not registered yet');
      return AppRouter.login;
    }

    final isLoggedIn = _checkAuthStatus();
    final isLoggingIn = state.matchedLocation == AppRouter.login;

    debugPrint('Redirect check - isLoggedIn: $isLoggedIn, isLoggingIn: $isLoggingIn, location: ${state.matchedLocation}');

    if (!isLoggedIn && !isLoggingIn) {
      debugPrint('Redirecting to login');
      return AppRouter.login;
    }

    if (isLoggedIn && isLoggingIn) {
      debugPrint('Already logged in, redirecting to home');
      return AppRouter.home;
    }

    return null; // No redirect needed
  } catch (e) {
    debugPrint('Error in redirect logic: $e');
    return AppRouter.login;
  }
}

bool _checkAuthStatus() {
  try {
    if (!locator.isRegistered<SharedPreferences>()) {
      return false;
    }
    final prefs = locator<SharedPreferences>();
    final hasToken = prefs.containsKey('access_token');
    final token = prefs.getString('access_token');
    return hasToken && token != null && token.isNotEmpty;
  } catch (e) {
    debugPrint('Error checking auth status: $e');
    return false;
  }
}

final routes = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: AppRouter.login,
  navigatorKey: AppRouter.navigatorKey,
  redirect: _redirectLogic,
  routes: [
    GoRoute(
      path: AppRouter.login,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRouter.createProduct,
      name: 'createProduct',
      builder: (context, state) => const CreateProductScreen(),
    ),
    StatefulShellRoute(
      parentNavigatorKey: AppRouter.navigatorKey,
      pageBuilder: (context, state, navigationShell) => CustomTransitionPage(
        key: state.pageKey,
        child: navigationShell,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
      builder: (_, __, child) => child,
      navigatorContainerBuilder: (context, navShell, children) =>
          ShellScreen(navShell: navShell, children: children),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.home,
              name: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.products,
              name: 'products',
              builder: (context, state) => const ProductsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.go(AppRouter.home);
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  ),
  refreshListenable: GoRouterRefreshListenable(),
);

// Listenable to refresh routes when auth state changes
class GoRouterRefreshListenable extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void setLoggedIn(bool value) {
    if (_isLoggedIn != value) {
      _isLoggedIn = value;
      debugPrint('Auth state changed to: $value');
      notifyListeners();
    }
  }
}