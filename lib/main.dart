import 'package:flutter/material.dart';
import 'package:optom/core/di/service_locator.dart';
import 'package:optom/core/theme/app_theme.dart';
import 'package:optom/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Product Management',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeData,
      themeMode: ThemeMode.light,
      routerDelegate: routes.routerDelegate,
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
    );
  }
}
