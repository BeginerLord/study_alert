import 'package:flutter/material.dart';

class BusuuColors {
  // Primary blues
  static const blue900 = Color(0xFF0829CA);
  static const blue800 = Color(0xFF0523A3);
  static const blue700 = Color(0xFF0020E5);
  static const blue600 = Color(0xFF286BF4);
  static const blue400 = Color(0xFF5F9BE3);
  static const blue200 = Color(0xFFA1D2EE);

  // Accent greens
  static const green500 = Color(0xFF28D052); // CTA principal
  static const green400 = Color(0xFF1FA266);
  static const teal500  = Color(0xFF177A7B);

  // Neutrals
  static const white100 = Color(0xFFFAFBFE);
  static const pureWhite = Color(0xFFFFFFFF);

  /// Gradiente principal usado en los headers de Busuu.
  static const primaryGradient = LinearGradient(
    colors: [blue700, blue600, blue400, blue200],
    stops: [0.0, 0.4, 0.75, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Gradiente para botones “Learn for free”.
  static const ctaGradient = LinearGradient(
    colors: [green500, green400],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// Tema listo para MaterialApp
class BusuuTheme {
  static ThemeData get theme => ThemeData(
        brightness: Brightness.light,
        primaryColor: BusuuColors.blue700,
        scaffoldBackgroundColor: BusuuColors.white100,
        colorScheme: const ColorScheme.light().copyWith(
          primary: BusuuColors.blue700,
          secondary: BusuuColors.green500,
          onPrimary: BusuuColors.pureWhite,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: BusuuColors.green500,
            foregroundColor: BusuuColors.pureWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );
}