import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optom/features/home/home_screen.dart';
import 'package:optom/features/products/craete_product_screen.dart';
import 'package:optom/features/products/product_screen.dart';
import 'package:optom/features/shell/shell_screen.dart';

abstract class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // static const initialRoute = '/';
  static const home = '/home';
  static const products = '/products';
  static const createProduct = '/create-product';

  static final routes = GoRouter(
    initialLocation: products,
    navigatorKey: navigatorKey,
    routes: [

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
            // Fade transition for the entire shell route
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
  );
}
