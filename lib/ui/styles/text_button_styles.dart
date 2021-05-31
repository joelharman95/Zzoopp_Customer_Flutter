import 'package:flutter/material.dart';

import 'colors.dart';

class TextButtonStyles {
  static ButtonStyle getTextButtonStyle(
      {double minHeight,
      double minWidth,
      Color color,
      EdgeInsets padding,
      OutlinedBorder shape}) {
    return TextButton.styleFrom(
        minimumSize: Size(minWidth ?? 140.0, minHeight ?? 40.0),
        primary: Colors.black12,
        backgroundColor: color ?? AppColors.primaryColor,
        shape: shape ?? RoundedRectangleBorder(),
        padding: padding ?? EdgeInsets.all(0));
  }
}
