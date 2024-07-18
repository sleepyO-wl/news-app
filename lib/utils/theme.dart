import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Colors.white,
  primary: const Color(0xFF0c54be),
  surface: const Color(0xFFced3dc),
  secondary: const Color(0xFFf5f9fd),
  tertiary: const Color(0xFF303f60),
);

final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: colorScheme.surface,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
    ),
    titleSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
    ),
  ),
);