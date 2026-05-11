//  Color palette for the app
//  Used across all screens for consistent theming and styling.
import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF6A11CB);
  static const secondary = Color(0xFF2575FC);

  static const background = Color(0xFFF5F5F5);
  static const card = Colors.white;

  static const textDark = Colors.black;
  static const textLight = Colors.white;

  static const textSecondaryDark = Colors.black54;
  static const textSecondaryLight = Colors.white70;
}

class AppTextStyles {
  static const darkTitle = TextStyle(
    color: AppColors.textDark,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const darkSubtitle = TextStyle(
    color: AppColors.textSecondaryDark,
    fontSize: 14,
  );

  static const lightTitle = TextStyle(
    color: AppColors.textLight,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const lightSubtitle = TextStyle(
    color: AppColors.textSecondaryLight,
    fontSize: 14,
  );
}