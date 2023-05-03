import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/utils/appcolors_utils.dart';

class ThemeUtils {
  static final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0,
          elevation: 0,
          backgroundColor: AppColors.appbarBackgroundColor),
      scaffoldBackgroundColor: AppColors.scafoldBackgroundColor,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.roboto().fontFamily,
      iconTheme: const IconThemeData(color: Colors.white),
      primaryColor: AppColors.primaryColor,
      cardTheme: const CardTheme(color: AppColors.cardBackgroundColor));
}
