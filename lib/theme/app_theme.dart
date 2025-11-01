import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 🎨 Colores globales usados en toda la app
  static const Color primaryLight = Color(0xFF6750A4);
  static const Color successLight = Color(0xFF4CAF50);
  static const Color errorLight = Color(0xFFF44336);
  static const Color warningLight = Color(0xFFFFC107);
  static const Color dividerLight = Color(0xFFBDBDBD);
  static const Color textMediumEmphasisLight = Color(0xFF616161);

  /// 🌞 Tema claro
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryLight,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.white,
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        titleTextStyle: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: GoogleFonts.robotoTextTheme(),
      tabBarTheme: TabBarTheme(
        labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w600),
        unselectedLabelStyle:
            GoogleFonts.roboto(fontWeight: FontWeight.w400),
        labelColor: primaryLight,
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: primaryLight,
      ),
    );
  }

  /// 🌚 Tema oscuro
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryLight,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardTheme: CardTheme(
        color: const Color(0xFF1E1E1E),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 1,
        titleTextStyle: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
      tabBarTheme: TabBarTheme(
        labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w600),
        unselectedLabelStyle:
            GoogleFonts.roboto(fontWeight: FontWeight.w400),
        labelColor: primaryLight,
        unselectedLabelColor: Colors.grey[400],
        indicatorColor: primaryLight,
      ),
    );
  }
}
