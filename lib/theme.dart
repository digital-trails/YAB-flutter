import 'package:flutter/material.dart';

/// Color palette mirroring src/constants/theme.ts from YAB-react.
class AppColors {
  const AppColors({
    required this.text,
    required this.background,
    required this.backgroundElement,
    required this.backgroundSelected,
    required this.textSecondary,
  });

  final Color text;
  final Color background;
  final Color backgroundElement;
  final Color backgroundSelected;
  final Color textSecondary;

  static const light = AppColors(
    text: Color(0xFF000000),
    background: Color(0xFFFFFFFF),
    backgroundElement: Color(0xFFF0F0F3),
    backgroundSelected: Color(0xFFE0E1E6),
    textSecondary: Color(0xFF60646C),
  );

  static const dark = AppColors(
    text: Color(0xFFFFFFFF),
    background: Color(0xFF000000),
    backgroundElement: Color(0xFF212225),
    backgroundSelected: Color(0xFF2E3135),
    textSecondary: Color(0xFFB0B4BA),
  );
}

/// Spacing scale mirroring `Spacing` in theme.ts.
class Spacing {
  static const double half = 2;
  static const double one = 4;
  static const double two = 8;
  static const double three = 16;
  static const double four = 24;
  static const double five = 32;
  static const double six = 64;
}

const double kMaxContentWidth = 800;

/// Brand color used for the splash overlay (matches expo-splash-screen config).
const Color kSplashColor = Color(0xFF208AEF);

/// Exposes the active [AppColors] for the current brightness.
extension AppColorsContext on BuildContext {
  AppColors get colors =>
      Theme.of(this).brightness == Brightness.dark ? AppColors.dark : AppColors.light;
}
