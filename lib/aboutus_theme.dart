// app_theme.dart
import 'package:flutter/material.dart';

class AboutUsTheme {
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: const Color(0xFFE4002B), // SMU Red
      secondaryHeaderColor: const Color(0xFF003D73), // SMU Blue
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFE4002B),
        foregroundColor: Colors.white,
      ),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFE4002B),
        secondary: Color(0xFF003D73),
        surface: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFFE4002B),
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF003D73),
        ),
        bodyLarge: TextStyle(
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(
          color: Colors.black54,
        ),
      ),
      useMaterial3: true,
    );
  }
}
