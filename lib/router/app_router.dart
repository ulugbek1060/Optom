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

  static FutureOr<String?> _redirectLogic(
    BuildContext context,
    GoRouterState state,
  ) {
    final isLoggedIn = _checkAuthStatus();
    final isLoggingIn = state.matchedLocation == login;
    if (!isLoggedIn && !isLoggingIn) return login;
    if (isLoggedIn && isLoggingIn) return home;
    return state.matchedLocation;
  }

  static bool _checkAuthStatus() {
    final prefs = locator<SharedPreferences>();
    return prefs.containsKey('access_token');
    return false;
  }

  static final routes = GoRouter(
    initialLocation: products,
    navigatorKey: navigatorKey,
    redirect: _redirectLogic,
    routes: [
      GoRoute(
        path: AppRouter.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRouter.createProduct,
        builder: (context, state) => CreateProductScreen(),
      ),
      StatefulShellRoute(
        parentNavigatorKey: navigatorKey,
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
                builder: (context, state) => HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouter.products,
                builder: (context, state) => ProductsScreen(),
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
                  context.go(home);
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
}

// Listenable to refresh routes when auth state changes
class GoRouterRefreshListenable extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void setLoggedIn(bool value) {
    if (_isLoggedIn != value) {
      _isLoggedIn = value;
      notifyListeners();
    }
  }
}
