import 'package:flutter/material.dart';
import 'package:optom/core/theme/app_colors.dart';
import 'package:optom/core/theme/app_size.dart';
import 'package:optom/core/theme/app_typography.dart';

abstract class AppTheme {

  static double get _buttonsBorderRadius  => 6.0;

  static final _flatButtonStyle = TextButton.styleFrom(
    textStyle: AppTypography.medium().labelMedium.copyWith(
      fontWeight: FontWeight.w300,
    ),
    padding: EdgeInsets.symmetric(horizontal: 16),
    overlayColor: AppColors.secondaryColor.withAlpha(128),
    fixedSize: const Size(double.infinity, 48),
    minimumSize: const Size(double.infinity, 48),
  );

  static final _elevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: AppColors.secondaryColor,
    textStyle: TextStyle(
      fontFamily: 'Manrope-Medium',
      color: AppColors.onPrimaryColor,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    elevation: 0.2,
    shadowColor: Colors.black54,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_buttonsBorderRadius))),
  );

  static final _outlinedButtonStyle = OutlinedButton.styleFrom(
    textStyle: TextStyle(
      fontFamily: 'Manrope-Medium',
      color: AppColors.onPrimaryColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    minimumSize: const Size(double.infinity, 48),
    shape: RoundedRectangleBorder(
      borderRadius:  BorderRadius.all(Radius.circular(16)),
      side: const BorderSide(
        color: AppColors.secondaryColor,
        width: AppSize.defBorderSize,
      ),
    ),
  );

  static final _inputDecoration = InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.lowEmphasized,
        width: AppSize.defBorderSize,
      ),
      borderRadius: 12.borderRadius,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.lowEmphasized,
        width: AppSize.defBorderSize,
      ),
      borderRadius: 12.borderRadius,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF1BBD51),
        width: AppSize.defBorderSize,
      ),
      borderRadius: 12.borderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: AppSize.defBorderSize),
      borderRadius: 12.borderRadius,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: AppSize.defBorderSize),
      borderRadius: 12.borderRadius,
    ),
    labelStyle: TextStyle(color: Color(0xFF1BBD51), fontSize: 14),
    hintStyle: TextStyle(color: AppColors.highEmphasized, fontSize: 14),
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    fillColor: Colors.white,
  );

  static final _textSelectionTheme = const TextSelectionThemeData(
    cursorColor: AppColors.secondaryColor,
    selectionHandleColor: AppColors.secondaryColor,
  );

  static final _dialogTheme = DialogThemeData(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: 16.borderRadius),
    // Shape of the dialog
    titleTextStyle: AppTypography.bold().titleLarge.copyWith(
      color: Colors.black,
    ),
    // Style for the title text
    contentTextStyle: AppTypography.normal().bodyLarge.copyWith(
      color: Colors.black,
    ),
    // Style for the content text
    actionsPadding: 16.allPadding,
  );

  static final lightThemeData = ThemeData(
    useMaterial3: true,
    primarySwatch: AppColors.primarySwatch,
    splashColor: AppColors.secondaryColor,
    hoverColor: Colors.transparent,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    fontFamily: 'Manrope',
    textTheme: TextTheme(
      displayLarge: AppTypography.normal().displayLarge,
      displayMedium: AppTypography.normal().displayMedium,
      displaySmall: AppTypography.normal().displaySmall,
      headlineLarge: AppTypography.normal().headlineLarge,
      headlineMedium: AppTypography.normal().headlineMedium,
      headlineSmall: AppTypography.normal().headlineSmall,
      titleLarge: AppTypography.normal().titleLarge,
      titleMedium: AppTypography.normal().titleMedium,
      titleSmall: AppTypography.normal().titleSmall,
      bodyLarge: AppTypography.normal().bodyLarge,
      bodyMedium: AppTypography.normal().bodyMedium,
      bodySmall: AppTypography.normal().bodySmall,
      labelLarge: AppTypography.normal().labelLarge,
      labelMedium: AppTypography.normal().labelMedium,
      labelSmall: AppTypography.normal().labelSmall,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.onBackgroundColor),
      titleTextStyle: TextStyle(
        fontFamily: 'Manrope',
        color: AppColors.onPrimaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.onPrimaryColor,
      secondary: AppColors.secondaryColor,
      onSecondary: AppColors.onSecondaryColor,
      error: AppColors.errorColor,
      onError: AppColors.onErrorColor,
      surface: AppColors.backgroundColor,
      onSurface: AppColors.onBackgroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: _elevatedButtonStyle),
    textButtonTheme: TextButtonThemeData(style: _flatButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: _outlinedButtonStyle),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
    inputDecorationTheme: _inputDecoration,
    textSelectionTheme: _textSelectionTheme,
    dialogTheme: _dialogTheme,
  );
}
