import 'package:flutter/material.dart';

class AppColors {
  // Basic colors
  static const lightBackgroundColor = const Color(0xFFFFFFFF);
  static const darkBackgroundColor = const Color(0xFF000000);
  static  const greyColor = const Color(0xFF9c9c9c);
  static const lightGreyColor = const Color(0xFFf8f8f8);

  static final primaryColor = MaterialColor(0xfff07150, {
    50: Color.fromRGBO(207, 10, 44, 0.1),
    100: Color.fromRGBO(207, 10, 44, 0.2),
    200: Color.fromRGBO(207, 10, 44, 0.3),
    300: Color.fromRGBO(207, 10, 44, 0.4),
    400: Color.fromRGBO(207, 10, 44, 0.5),
    500: Color.fromRGBO(207, 10, 44, 0.6),
    600: Color.fromRGBO(207, 10, 44, 0.7),
    700: Color.fromRGBO(207, 10, 44, 0.8),
    800: Color.fromRGBO(207, 10, 44, 0.9),
    900: Color.fromRGBO(207, 10, 44, 1),
  });
  static const errorColor = const Color(0xFFB71C1C);

  static final Color statusBarColor = Color(0x4D000000);
}
