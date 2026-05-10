import 'package:flutter/material.dart';

class AppSize {
  AppSize._();
  static const double defBorderSize = 1.5;
  static const double defButtonsHeight = 48.0;
}

// for height and width
extension SizeExtension on num {
  Widget get hSpace => SizedBox(width: toDouble());
  Widget get vSpace => SizedBox(height: toDouble());
}

// for padding and margin
extension PaddingMarginExtension on num {
  EdgeInsets get hPadding => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vPadding => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get allPadding => EdgeInsets.all(toDouble());
  EdgeInsets get topPadding => EdgeInsets.only(top: toDouble());
  EdgeInsets get bottomPadding => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get leftPadding => EdgeInsets.only(left: toDouble());
  EdgeInsets get rightPadding => EdgeInsets.only(right: toDouble());
}

// for border radius
extension BorderRadiusExtension on num {
  BorderRadius get borderRadius => BorderRadius.circular(toDouble());
  Radius get circularRadius => Radius.circular(toDouble());
  BorderRadius get topBorders =>
      BorderRadius.vertical(top: Radius.circular(toDouble()));
  BorderRadius get bottomBorders =>
      BorderRadius.vertical(bottom: Radius.circular(toDouble()));
  BorderRadius get leftBorders =>
      BorderRadius.horizontal(left: Radius.circular(toDouble()));
  BorderRadius get rightBorders =>
      BorderRadius.horizontal(right: Radius.circular(toDouble()));
}

// for margin
extension MarginExtension on num {
  EdgeInsets get hMargin => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vMargin => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get allMargin => EdgeInsets.all(toDouble());
}
