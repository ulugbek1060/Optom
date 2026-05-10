import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(26, 252, 252, 252),
      Color.fromARGB(0, 255, 255, 255),
    ],
  );

  static const primarySwatch = MaterialColor(0xFF2196F3, <int, Color>{
    50: Color(0xFFE3F2FD),
    100: Color(0xFFBBDEFB),
    200: Color(0xFF90CAF9),
    300: Color(0xFF64B5F6),
    400: Color(0xFF42A5F5),
    500: primaryColor,
    600: Color(0xFF1E88E5),
    700: Color(0xFF1976D2),
    800: Color(0xFF1565C0),
    900: Color(0xFF0D47A1),
  });

  static const splashColor = Color(0xFF2196F3);

  /// Colors For the Light Theme
  static const backgroundColor = Color(0xFFF5F5F5);
  static const onBackgroundColor = Color(0xFF15141F);
  static const primaryColor = Color(0xFF2196F3); // Changed to blue
  static const onPrimaryColor = Color(0xFFFFFFFF); // White text on blue
  static const secondaryColor = Color(0xFF1BBD51); // Keeping green as secondary
  static const onSecondaryColor = Color(0xFFFFFFFF);
  static const surfaceColor = Color(0xFFFFFFFF);
  static const onSurfaceColor = Color(0xFF15141F);
  static const errorColor = Color(0xFFFF1B1B);
  static const onErrorColor = Color(0xFFFFFFFF);
  static const highEmphasized = Color(0xFF686873);
  static const mediumEmphasized = Color(0xFFBCBCBC);
  static const lowEmphasized = Color(0xFFF5F5F5);
  static const dashedLineColor = Color(0xFFEAECF0);

  /// Colors For The dark theme
}
