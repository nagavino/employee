import 'package:flutter/material.dart';

/* Paddings and Border Radius */
class Constants {
  Constants._();
  static const double sidePaddingAll = 16;
  static const double inputBoxVerticalSpace = 16;
  static const double inputBoxHorizontalSpace = 16;
  static const double btnHorizontalSpace = 16;
  static const double inputBorderRadius = 8;
  static const double btnBorderRadius = 10;
  static const double sideHorizontalSpace = 16;
  static const double sideVerticalSpace = 15;
  static const double inputIconSize = 18;
}

/* Common Colors */
Color transparent = Colors.transparent;
Color black = const Color(0xff000000);
Color white = Colors.white;

/* Theme Colors */
Color primaryTextColor = black;
Color secondaryTextColor = const Color(0xff999999);
Color primaryColor = const Color(0xff108DDA);
Color secondaryColor = const Color(0xff999999);
Color primaryBg = Colors.white;
Color dividerColor = const Color(0xFF8c98a8).withOpacity(0.1);
Color scaffoldBg = const Color(0xfff2f2f2);
Color themeColorText = primaryColor;

/* Input Theme Colors */
Color focusColor = primaryColor;
Color inputColor = Colors.grey;
Color inputBorderColor = Colors.grey.shade200;
Color inputTextColor = const Color(0xff999999);
FontWeight inputFw500 = FontWeight.w500;

/* icon color */
Color iconColor1 = primaryColor;
Color iconColor2 = white;

/* btn color */
Color btnColor = primaryColor; /* Device Size */

/* Device Sizes */
double desktopXl = 1280;
double desktop = 1024;
double laptop = 960;

double tabletXl = 768;
double tabletM = 640;
double tabletXs = 480;

double mobileLargeSize = 500;
double mobileMediumSize = 380;
double mobileMiniSize = 320;
double mobileXs = 280;
