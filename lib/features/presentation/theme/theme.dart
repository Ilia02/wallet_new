import 'package:flutter/material.dart';

const backgroundAppLight = Color.fromARGB(255, 239, 239, 239);
const backgroundAppDark = Color(0xFF121212);
const titleTextLight = Colors.black87;
const titleTextDark = Colors.white70;
const cardTextMediumLight = Color.fromARGB(255, 191, 192, 195);
const cardTextMediumDark = Colors.grey;

class AppThemes {
  static final ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.tealAccent,
    scaffoldBackgroundColor: backgroundAppLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundAppLight,
      iconTheme: IconThemeData(size: 30, color: Colors.black),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      color: Colors.white,
      shadowColor: Colors.black54,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 36, fontWeight: FontWeight.bold, color: titleTextLight),
      displayMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: titleTextLight),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: cardTextMediumLight),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
  );

  static final ThemeData darkTheme = defaultTheme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundAppDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundAppDark,
      iconTheme: IconThemeData(size: 30, color: Colors.white),
    ),
    cardTheme: defaultTheme.cardTheme.copyWith(
      color: Color(0xFF1E1E1E),
      shadowColor: Colors.black,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 36, fontWeight: FontWeight.bold, color: titleTextDark),
      displayMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: titleTextDark),
      bodyMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: cardTextMediumDark),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
    ),
  );

  static final ThemeData lightTheme = defaultTheme.copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: backgroundAppLight,
  );
}
