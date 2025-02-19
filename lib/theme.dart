import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

// Our light/Primary Theme
ThemeData themeData(BuildContext context) {
  return ThemeData(
    appBarTheme: appBarTheme,
    primaryColor: kPrimaryColor,
    // accentColor: kAccentLightColor,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: kBodyTextColorLight),
    // accentIconTheme: IconThemeData(color: kAccentIconLightColor),
    primaryIconTheme: IconThemeData(color: kPrimaryIconLightColor),
    textTheme: GoogleFonts.quicksandTextTheme().copyWith(
      bodyLarge: GoogleFonts.quicksand().copyWith(color: kBodyTextColorLight),
      bodyMedium: GoogleFonts.quicksand().copyWith(color: kBodyTextColorLight, fontWeight: FontWeight.bold),
      headlineMedium: GoogleFonts.quicksand().copyWith(color: kTitleTextLightColor, fontSize: 32),
      displayLarge: GoogleFonts.quicksand().copyWith(color: kTitleTextLightColor, fontSize: 80),
    ),
    colorScheme: ColorScheme.light(
      secondary: kSecondaryLightColor,
      // on light theme surface = Colors.white by default
    ).copyWith(background: Colors.white),
  );
}

// Dark Them
ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    // accentColor: kAccentDarkColor,
    scaffoldBackgroundColor: Color(0xFF0D0C0E),
    appBarTheme: appBarTheme,
    iconTheme: IconThemeData(color: kBodyTextColorDark),
    // accentIconTheme: IconThemeData(color: kAccentIconDarkColor),
    primaryIconTheme: IconThemeData(color: kPrimaryIconDarkColor),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyLarge: TextStyle(color: kBodyTextColorDark),
      bodyMedium: TextStyle(color: kBodyTextColorDark),
      headlineMedium: TextStyle(color: kTitleTextDarkColor, fontSize: 32),
      displayLarge: TextStyle(color: kTitleTextDarkColor, fontSize: 80),
    ),
    colorScheme: ColorScheme.light(
      secondary: kSecondaryDarkColor,
      surface: kSurfaceDarkColor,
    ).copyWith(background: kBackgroundDarkColor),
  );
}

AppBarTheme appBarTheme = AppBarTheme(color: Colors.transparent, elevation: 0);
