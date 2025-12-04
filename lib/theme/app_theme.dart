import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF6C63FF);
  static const Color accent = Color(0xFF00C896);
  static const Color danger = Color(0xFFFF6B6B);
  static const Color background = Color(0xFFF5F6FA);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: accent,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    useMaterial3: true,
  );
}
