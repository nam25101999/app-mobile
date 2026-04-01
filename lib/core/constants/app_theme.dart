import 'package:flutter/material.dart';
import 'colors_app.dart';
import 'app_text_styles.dart';
import 'package:demo/core/constants/app_sizes.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(

    /// =========================
    /// PRIMARY COLOR
    /// =========================
    primaryColor: ColorsApp.primary,

    scaffoldBackgroundColor: Colors.white,

    colorScheme: const ColorScheme.light(
      primary: ColorsApp.primary,
      secondary: ColorsApp.primary,
    ),

    /// =========================
    /// APP BAR
    /// =========================
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    /// =========================
    /// TEXT THEME
    /// =========================
    textTheme: const TextTheme(
      headlineLarge: AppTextStyles.headline,
      titleLarge: AppTextStyles.title,
      bodyMedium: AppTextStyles.body,
      bodySmall: AppTextStyles.small,
    ),

    /// =========================
    /// ELEVATED BUTTON
    /// =========================
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsApp.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        ),
        textStyle: AppTextStyles.button,
      ),
    ),

    /// =========================
    /// TEXT BUTTON
    /// =========================
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorsApp.primary,
        textStyle: AppTextStyles.link,
      ),
    ),

    /// =========================
    /// INPUT FIELD
    /// =========================
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.lg,
        vertical: AppSizes.md,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputRadius),
        borderSide: const BorderSide(color: Colors.black12),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputRadius),
        borderSide: const BorderSide(color: Colors.black12),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputRadius),
        borderSide: const BorderSide(color: ColorsApp.primary),
      ),

      hintStyle: AppTextStyles.hint,
      labelStyle: AppTextStyles.label,
    ),

    /// =========================
    /// ICON THEME
    /// =========================
    iconTheme: const IconThemeData(
      color: Colors.black87,
      size: AppSizes.iconLg,
    ),

    /// =========================
    /// CARD
    /// =========================
    cardTheme: CardThemeData(
      elevation: AppSizes.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
    ),
  );
}