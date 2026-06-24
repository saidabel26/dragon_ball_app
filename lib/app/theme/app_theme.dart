import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ── Palette ──────────────────────────────────────────────────────────────
  static const Color background = Color(0xFF08080F);
  static const Color surface = Color(0xFF12121E);
  static const Color surfaceVariant = Color(0xFF1A1A2E);
  static const Color orange = Color(0xFFFF6B00);
  static const Color orangeLight = Color(0xFFFF8C38);
  static const Color gold = Color(0xFFFFD700);
  static const Color blue = Color(0xFF1E90FF);
  static const Color blueLight = Color(0xFF4DAFFF);
  static const Color textPrimary = Color(0xFFF0F0F0);
  static const Color textSecondary = Color(0xFFAAAAAA);
  static const Color divider = Color(0xFF2A2A40);

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: orange,
        secondary: gold,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: textPrimary,
      ),
      textTheme: GoogleFonts.rajdhaniTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 48,
            letterSpacing: 2,
          ),
          displayMedium: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 36,
            letterSpacing: 1.5,
          ),
          headlineLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 28,
            letterSpacing: 1,
          ),
          headlineMedium: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
          titleLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
          bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
          labelLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 1.2,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: orange),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: orange,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 12,
      ),
      cardTheme: CardThemeData(
        color: surfaceVariant,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: orange,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
