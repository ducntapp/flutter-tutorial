import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final dartTheme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 147, 229, 250),
    brightness: Brightness.dark,
    surface: const Color.fromARGB(255, 42, 51, 59),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
);

final nativeColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 54, 54, 54),
  brightness: Brightness.dark,
  background: Color.fromARGB(255, 59, 58, 59),
);

final nativeTheme = ThemeData().copyWith(
  colorScheme: nativeColorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.normal,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.w500,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
  ),
  scaffoldBackgroundColor: nativeColorScheme.background,
);

