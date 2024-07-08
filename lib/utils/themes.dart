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
  colorScheme: ColorScheme.light(
    background: Colors.white70.withOpacity(0.3),
    primary: Colors.black,
    secondary: Colors.black54,
    tertiary: Colors.black38,
    primaryContainer: Colors.blueGrey[600]?.withOpacity(0.5),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: textTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black.withOpacity(0.8),
    elevation: 0,
  ),
  colorScheme: ColorScheme.dark(
    background: const Color.fromARGB(255, 24, 24, 29),
    primary: Colors.white,
    secondary: Colors.grey,
    tertiary: const Color.fromRGBO(134, 134, 134, 1),
    primaryContainer: const Color.fromRGBO(96, 125, 139, 1).withOpacity(0.3),
  ),
);
