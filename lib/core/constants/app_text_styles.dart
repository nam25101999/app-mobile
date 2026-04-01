import 'package:flutter/material.dart';
import 'app_sizes.dart';
import 'colors_app.dart';

class AppTextStyles {

  /// =============================
  /// HEADLINE
  /// =============================
  static const TextStyle headline = TextStyle(
    fontSize: AppSizes.textHeadline,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  /// =============================
  /// TITLE
  /// =============================
  static const TextStyle title = TextStyle(
    fontSize: AppSizes.textTitle,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  /// =============================
  /// LARGE TEXT
  /// =============================
  static const TextStyle large = TextStyle(
    fontSize: AppSizes.textXxl,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  /// =============================
  /// BODY
  /// =============================
  static const TextStyle body = TextStyle(
    fontSize: AppSizes.textMd,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
    height: 1.5,
  );

  /// =============================
  /// BODY GREY (description)
  /// =============================
  static const TextStyle bodyGrey = TextStyle(
    fontSize: AppSizes.textMd,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
    height: 1.5,
  );

  /// =============================
  /// SMALL TEXT
  /// =============================
  static const TextStyle small = TextStyle(
    fontSize: AppSizes.textSm,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );

  /// =============================
  /// BUTTON TEXT
  /// =============================
  static const TextStyle button = TextStyle(
    fontSize: AppSizes.textMd,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  /// =============================
  /// LINK TEXT
  /// =============================
  static const TextStyle link = TextStyle(
    fontSize: AppSizes.textSm,
    fontWeight: FontWeight.w500,
    color: ColorsApp.primary,
  );

  /// =============================
  /// INPUT LABEL
  /// =============================
  static const TextStyle label = TextStyle(
    fontSize: AppSizes.textXs,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  /// =============================
  /// INPUT HINT
  /// =============================
  static const TextStyle hint = TextStyle(
    fontSize: AppSizes.textSm,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}