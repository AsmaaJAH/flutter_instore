//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:flutter/material.dart';
//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_fonts.dart';

class ModeThemeManager {
  const ModeThemeManager._();
  // -------------------------- colorsScheme ---------------------------------
  static final colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: AppColors.commonWhite,
  );

  static final darkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: AppColors.commonWhite,
  );
//-------------------------------  Themes ---------------------------------------
  static final lightThemes = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    brightness: Brightness.light,
    fontFamily: AppFonts.fontFamily,
    primaryColor: AppColors.primary,
    // floatingActionButtonTheme: const FloatingActionButtonThemeData()
    //     .copyWith(backgroundColor: AppColors.primary),
    dialogBackgroundColor: AppColors.offWhiteBackground,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
    ),
  );

  static final darkThemes = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: darkColorScheme,
    fontFamily: AppFonts.fontFamily,
    primaryColor: AppColors.primary,
    dialogBackgroundColor: AppColors.offWhiteBackground,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
    ),
  );
}
