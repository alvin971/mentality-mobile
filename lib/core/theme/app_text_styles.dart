import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Source Serif 4 — titres, accroche, pull quotes
  static TextStyle serif({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.textPrimary,
    double? height,
    FontStyle fontStyle = FontStyle.normal,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.sourceSerif4(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
      );

  // DM Sans — UI, corps de texte, boutons, labels
  static TextStyle sans({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.textPrimary,
    double? height,
  }) =>
      GoogleFonts.dmSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      );

  // DM Mono — scores, données numériques, §
  static TextStyle mono({
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.textTertiary,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.dmMono(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  // Shortcuts
  static TextStyle get heroTitle => serif(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle get sectionTitle => serif(
        fontSize: 26,
        fontWeight: FontWeight.w500,
        height: 1.25,
        letterSpacing: -0.3,
      );

  static TextStyle get cardTitle => serif(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.3,
      );

  static TextStyle get sectionNumber => mono(
        fontSize: 11,
        letterSpacing: 2,
        color: AppColors.textTertiary,
      );

  static TextStyle get body => sans(
        fontSize: 15,
        color: AppColors.textSecondary,
        height: 1.65,
      );

  static TextStyle get bodySmall => sans(
        fontSize: 13,
        color: AppColors.textTertiary,
        height: 1.5,
      );

  static TextStyle get label => sans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textTertiary,
      );

  static TextStyle get button => sans(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      );

  static TextStyle get statValue => serif(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: AppColors.accent,
      );

  static TextStyle get qiScore => mono(
        fontSize: 48,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );
}
