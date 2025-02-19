import 'package:flutter/material.dart';

import '../constants.dart';

const int _primaryValue = 0xff108DDA;

const MaterialColor customPrimarySwatch = MaterialColor(
  _primaryValue,
  <int, Color>{
    50: Color(0xffE3F2FD), // Lightest
    100: Color(0xffBBDEFB),
    200: Color(0xff90CAF9),
    300: Color(0xff64B5F6),
    400: Color(0xff42A5F5),
    500: Color(_primaryValue), // Base color
    600: Color(0xff0E7EC5),
    700: Color(0xff0C6FB0),
    800: Color(0xff0A609B),
    900: Color(0xff084F86), // Darkest
  },
);

class CustomThemes {
  // Light Theme
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: primaryColor,
      primarySwatch: customPrimarySwatch,
      scaffoldBackgroundColor: scaffoldBg,
      focusColor: focusColor, // input focused border color
      dividerColor: dividerColor,
      appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          toolbarTextStyle: TextStyle(color: white),
          titleTextStyle: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w700, color: white),
          iconTheme: IconThemeData(
            color: iconColor1,
          )),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: customPrimarySwatch.shade50,
          foregroundColor: Colors.blue, // Text color
          side: BorderSide(color: transparent, width: 0), // Border color
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.btnBorderRadius),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor, // Button background color
          foregroundColor: white, // Text color
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.btnBorderRadius),
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: btnColor, // பிரைமரி வண்ணம்
            ),
        buttonColor: btnColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior:
            FloatingLabelBehavior.never, // Hides floating label
        iconColor: primaryColor,
        prefixIconColor: primaryColor,
        filled: true,
        // fillColor: Colors.white, // Background color for text fields
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.inputBorderRadius),
          borderSide:
              BorderSide(color: inputBorderColor), // Global border color
        ),
        focusColor: primaryColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.inputBorderRadius),
          borderSide:
              BorderSide(color: inputBorderColor, width: 1), // Focus color
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.inputBorderRadius),
          borderSide: BorderSide(color: inputBorderColor),
        ),
        hintStyle: TextStyle(
            color: inputTextColor, fontSize: 14, fontWeight: FontWeight.w400),
        labelStyle: TextStyle(
            color: inputTextColor, fontSize: 14, fontWeight: FontWeight.w400),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: secondaryColor,
        surface: primaryBg,
      ),
      textTheme: TextTheme(
        /* headline1 */
        headlineLarge:
            TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: white),
        headlineMedium:
            TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: black),
        titleLarge: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: themeColorText),
        titleMedium: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, color: primaryTextColor),
        bodyLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: secondaryTextColor),
        bodyMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: secondaryTextColor),
      ),
      useMaterial3: true,
    );
  }
}
