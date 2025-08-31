import 'package:flutter/material.dart';

//fonts
const String kFontFamily = "BankGothic";
const String kSecondaryFontFamily = "Roboto";
// Core brand colors
const Color kBlackColor = Color(0xFF000000);
const Color kWhiteColor = Color(0xFFFFFFFF);

// Primary (green family)
const Color kSecondaryColor = Color(0xFF009b47); // Main green
const Color kLightSecondaryColor = Color(0xFF8BC34A); // Lighter green accent
const Color kDarkSecondaryColor = Color(
  0xFF006B33,
); // Darker green for contrast

const LinearGradient kL = LinearGradient(
  colors: [kLightPrimaryColor, kPrimaryColor],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const LinearGradient kLrtl = LinearGradient(
  colors: [kLightPrimaryColor, kPrimaryColor],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

LinearGradient kLightPrimaryGradient = LinearGradient(
  colors: [kPrimaryColor, kLightPrimaryColor],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

// Secondary (blue family)
const Color kPrimaryColor = Color(0xFF0077B6); // Main blue
const Color kLightPrimaryColor = Color(0xFF48CAE4); // Lighter blue accent
const Color kDarkPrimaryColor = Color(0xFF023E8A); // Darker blue

// Neutral grays
const Color kGreyColor = Color(0xFF9E9E9E);
const Color kLightGreyColor = Color(0xFFF5F5F5);
const Color kDarkGreyColor = Color(0xFF424242);

// Status indicators
const Color kSuccessColor = Color(0xFF4CAF50); // Approved
const Color kErrorColor = Color(0xFFE53935); // Declined
const Color kPendingColor = Color(0xFFFFB300); // Pending

//Define textStyle for Heading, Subheading, Body, placeholder
const TextStyle kHeadingTextStyle = TextStyle(
  fontFamily: kFontFamily,
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: kBlackColor,
);

const TextStyle kSubheadingTextStyle = TextStyle(
  fontFamily: kFontFamily,
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: kBlackColor,
);

const TextStyle kBodyTextStyle = TextStyle(
  fontFamily: kSecondaryFontFamily,
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: kBlackColor,
);

const TextStyle kPlaceholderTextStyle = TextStyle(
  fontFamily: kSecondaryFontFamily,
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: kGreyColor,
);

ThemeData lightTheme = ThemeData(
  fontFamily: kFontFamily,
  brightness: Brightness.light,
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kWhiteColor,
  appBarTheme: AppBarTheme(
    backgroundColor: kPrimaryColor,
    foregroundColor: kWhiteColor,
    elevation: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kLightGreyColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: kPrimaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: kPrimaryColor, width: 2),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 3,
      backgroundColor: kPrimaryColor,
      foregroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: kLightSecondaryColor,
    selectedColor: kSecondaryColor,
    labelStyle: TextStyle(color: kBlackColor),
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: kFontFamily,
  brightness: Brightness.dark,
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kBlackColor,
  appBarTheme: AppBarTheme(
    backgroundColor: kDarkPrimaryColor,
    foregroundColor: kWhiteColor,
    elevation: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kDarkGreyColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: kLightPrimaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: kPrimaryColor, width: 2),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor,
      foregroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: kDarkSecondaryColor,
    selectedColor: kSecondaryColor,
    labelStyle: TextStyle(color: kWhiteColor),
  ),
);
