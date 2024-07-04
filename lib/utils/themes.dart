import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme = TextTheme(
  bodyLarge: GoogleFonts.poppins(fontSize: 20.0),
  bodyMedium: GoogleFonts.poppins(fontSize: 18.0),
  bodySmall: GoogleFonts.poppins(fontSize: 16.0),
  titleLarge: GoogleFonts.poppins(fontSize: 20.0),
  titleSmall: GoogleFonts.poppins(fontSize: 16.0),
  titleMedium: GoogleFonts.poppins(fontSize: 18.0),
  labelLarge: GoogleFonts.poppins(fontSize: 20.0),
  labelSmall: GoogleFonts.poppins(fontSize: 16.0),
  labelMedium: GoogleFonts.poppins(fontSize: 18.0),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: textTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white.withOpacity(0.9),
    elevation: 0,
  ),
  colorScheme: const ColorScheme.light(
    background: Colors.white,
    primary: Colors.black,
    secondary: Colors.black54,
    tertiary: Color.fromRGBO(180, 180, 180, 1),
    surface: Color.fromRGBO(246, 246, 246, 1),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: textTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black.withOpacity(0.8),
    elevation: 0,
  ),
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255, 24, 24, 29),
    primary: Colors.white,
    secondary: Colors.white54,
    tertiary: Color.fromRGBO(117, 117, 117, 1),
    surface: Color.fromRGBO(27, 27, 27, 1),
  ),
);
