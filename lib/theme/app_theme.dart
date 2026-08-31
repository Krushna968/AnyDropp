import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryRed = Color(0xFFE23744);
  static const Color darkRed = Color(0xFFC92837);
  static const Color lightRed = Color(0xFFFFF1F2);
  
  // Neutral Colors
  static const Color background = Color(0xFFF5F6F8);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1C1C27);
  static const Color textSecondary = Color(0xFF6E717F);
  static const Color textMuted = Color(0xFF9E9FA8);
  static const Color dividerColor = Color(0xFFEBEBF0);
  static const Color borderLight = Color(0xFFE4E4EC);

  // Status & Accent Colors
  static const Color ratingGreen = Color(0xFF24963F);
  static const Color vegGreen = Color(0xFF0F8A65);
  static const Color nonVegRed = Color(0xFFE23744);
  static const Color nearFastGreen = Color(0xFF139D65);
  
  // Zomato Gold Palette
  static const Color goldCardBg = Color(0xFF181824);
  static const Color goldAccent = Color(0xFFECC568);
  static const Color goldAccentLight = Color(0xFFFBF1D5);
  static const Color goldBadgeBg = Color(0xFF332B1C);

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      primaryColor: primaryRed,
      colorScheme: const ColorScheme.light(
        primary: primaryRed,
        secondary: nearFastGreen,
        surface: surface,
        onSurface: textPrimary,
      ),
      textTheme: baseTextTheme.copyWith(
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: textMuted,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
