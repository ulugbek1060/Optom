import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:optom/core/di/service_locator.dart';
import 'package:optom/features/auth/login_screen.dart';
import 'package:optom/features/home/home_screen.dart';
import 'package:optom/features/products/craete_product_screen.dart';
import 'package:optom/features/products/product_screen.dart';
import 'package:optom/features/selling/product_detail.dart';
import 'package:optom/features/selling/sell_product_screen.dart';
import 'package:optom/features/selling/selling_screen.dart';
import 'package:optom/features/shell/shell_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const login = '/login';
  static const home = '/home';
  static const products = '/products';
  static const createProduct = '/create-product';
  static const selling = '/selling';
  static const sellProduct = '/sellProduct';
  static const productDetail = '/productDetail';
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

    debugPrint(
      'Redirect check - isLoggedIn: $isLoggedIn, isLoggingIn: $isLoggingIn, location: ${state.matchedLocation}',
    );

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
    // Login route with Cupertino transition
    GoRoute(
      path: AppRouter.login,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const LoginScreen(),
        restorationId: state.pageKey.value,
      ),
    ),

    // Create Product route with Cupertino transition
    GoRoute(
      path: AppRouter.createProduct,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const CreateProductScreen(),
        restorationId: state.pageKey.value,
      ),
    ),

    // Sell Product route with Cupertino transition
    GoRoute(
      path: AppRouter.sellProduct,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const SellProductScreen(),
        restorationId: state.pageKey.value,
      ),
    ),

    // Sell Product route with Cupertino transition
    GoRoute(
      path: AppRouter.productDetail,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child:  ProductDetailScreen(),
        restorationId: state.pageKey.value,
      ),
    ),

    // Main Shell Route with Cupertino transitions
    StatefulShellRoute(
      parentNavigatorKey: AppRouter.navigatorKey,
      pageBuilder: (context, state, navigationShell) => CupertinoPage(
        key: state.pageKey,
        child: navigationShell,
        restorationId: state.pageKey.value,
      ),
      builder: (_, __, child) => child,
      navigatorContainerBuilder: (context, navShell, children) =>
          ShellScreen(navShell: navShell, children: children),
      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.home,
              name: 'home',
              pageBuilder: (context, state) => CupertinoPage(
                key: state.pageKey,
                child: const HomeScreen(),
                restorationId: state.pageKey.value,
              ),
            ),
          ],
        ),

        // Selling Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.selling,
              name: 'selling',
              pageBuilder: (context, state) => CupertinoPage(
                key: state.pageKey,
                child: const SellingScreen(),
                restorationId: state.pageKey.value,
              ),
            ),
          ],
        ),

        // Products Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.products,
              name: 'products',
              pageBuilder: (context, state) => CupertinoPage(
                key: state.pageKey,
                child: const ProductsScreen(),
                restorationId: state.pageKey.value,
              ),
            ),
          ],
        ),
      ],
    ),
  ],

  // Error page with Cupertino style
  errorPageBuilder: (context, state) => CupertinoPage(
    key: state.pageKey,
    child: CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Error'),
        backgroundColor: CupertinoColors.systemRed,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.exclamationmark_triangle,
              size: 80,
              color: CupertinoColors.systemRed,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
            const SizedBox(height: 24),
            CupertinoButton(
              onPressed: () {
                context.go(AppRouter.home);
              },
              color: CupertinoColors.activeBlue,
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
    restorationId: 'error_page',
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
