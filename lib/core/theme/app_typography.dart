import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static const _bold = 'Manrope-Bold';
  static const _medium = 'Manrope-Medium';
  static const _light = 'Manrope-Light';
  static const _normal = 'Manrope';
  static const _extraBold = 'Manrope-ExtraBold';

  // ===== FACTORY METHODS =====
  static CustomTypography light() => CustomTypography(fontFamily: _light);
  static CustomTypography normal() => CustomTypography(fontFamily: _normal);
  static CustomTypography medium() => CustomTypography(fontFamily: _medium);
  static CustomTypography bold() => CustomTypography(fontFamily: _bold);
  static CustomTypography extraBold() =>
      CustomTypography(fontFamily: _extraBold);
}

class CustomTypography {
  final String? fontFamily;
  CustomTypography({this.fontFamily});
  TextStyle get displayLarge => TextStyle(fontFamily: fontFamily, fontSize: 57);
  TextStyle get displayMedium => TextStyle(fontFamily: fontFamily, fontSize: 45);
  TextStyle get displaySmall => TextStyle(fontFamily: fontFamily, fontSize: 36);
  TextStyle get headlineLarge => TextStyle(fontFamily: fontFamily, fontSize: 32);
  TextStyle get headlineMedium => TextStyle(fontFamily: fontFamily, fontSize: 28);
  TextStyle get headlineSmall => TextStyle(fontFamily: fontFamily, fontSize: 24);
  TextStyle get titleLarge => TextStyle(fontFamily: fontFamily, fontSize: 20);
  TextStyle get titleMedium => TextStyle(fontFamily: fontFamily, fontSize: 20);
  TextStyle get titleSmall => TextStyle(fontFamily: fontFamily, fontSize: 16);
  TextStyle get labelLarge => TextStyle(fontFamily: fontFamily, fontSize: 20);
  TextStyle get labelMedium => TextStyle(fontFamily: fontFamily, fontSize: 16);
  TextStyle get labelSmall => TextStyle(fontFamily: fontFamily, fontSize: 14);
  TextStyle get bodyLarge => TextStyle(fontFamily: fontFamily, fontSize: 16);
  TextStyle get bodyMedium => TextStyle(fontFamily: fontFamily, fontSize: 14);
  TextStyle get bodySmall => TextStyle(fontFamily: fontFamily, fontSize: 12);
}
