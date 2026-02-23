import 'package:flutter/material.dart';

class AppColors {
  // ========== LOGIN SCREEN SPECIFIC COLORS ==========
  static const Color cyberYellow = Color(0xFFFEDA15);   // Main LOGIN button, taxi icon
  static const Color pureWhite = Color(0xFFFFFFFF);     // Main background
  static const Color jetBlack = Color(0xFF222222);      // Brand name, primary text
  static const Color spanishGrey = Color(0xFF999999);   // Placeholder text, inactive icons
  static const Color silverSand = Color(0xFFDCDCDC);    // Subtle borders

  // ========== EXISTING FUTURISTIC / NEON COLORS ==========
  static const Color deepMidnightNavy = Color(0xFF0B0E2D); // Background
  static const Color electricCyan = Color(0xFF00F2FF);      // Primary accent, neon blue
  static const Color goldenTaxiYellow = Color(0xFFFFD700);  // Vehicle, highlights
  static const Color cyberGreen = Color(0xFF39FF14);        // Map pin, success

  // ========== ALIASES FOR BACKWARD COMPATIBILITY ==========
  static const Color white = pureWhite;
  static const Color black = jetBlack;
  static const Color grey = spanishGrey;
  static const Color borderGrey = silverSand;

  // ========== BACKGROUND & SURFACES ==========
  static const Color background = deepMidnightNavy;
  static const Color surfaceDark = Color(0xFF1A1F3D);       // Cards, sheets
  static const Color surfaceLight = Color(0xFF2A2F55);      // Elevated surfaces
  static const Color overlay = Color(0x80FFFFFF);          // Semi-transparent white

  // ========== PRIMARY & ACCENT ==========
  static const Color primary = electricCyan;
  static const Color primaryLight = Color(0xFF6EFFFF);      // Lighter cyan
  static const Color primaryDark = Color(0xFF00B0C0);       // Darker cyan
  static const Color primaryLighter = Color(0x1A00F2FF);   // Very light (for backgrounds)

  // ========== SECONDARY ACCENTS ==========
  static const Color secondary = cyberGreen;
  static const Color secondaryLight = Color(0xFF7AFF64);
  static const Color secondaryDark = Color(0xFF2DB800);

  // ========== VEHICLE / TAXI COLOR ==========
  static const Color taxiYellow = goldenTaxiYellow;
  static const Color taxiYellowLight = Color(0xFFFFE44D);
  static const Color taxiYellowDark = Color(0xFFCCAA00);

  // ========== STATUS COLORS ==========
  static const Color success = cyberGreen;
  static const Color successLight = Color(0x1A39FF14);
  static const Color error = Color.fromARGB(255, 241, 50, 50);
  static const Color errorLight = Color(0x1AFF4D4D);
  static const Color warning = Color(0xFFFFB800);
  static const Color warningLight = Color(0x1AFFB800);
  static const Color info = electricCyan;
  static const Color infoLight = Color(0x1A00F2FF);

  // ========== TEXT COLORS ==========
  static const Color textPrimary = jetBlack;           // For light theme
  static const Color textSecondary = spanishGrey;
  static const Color textDisabled = Color(0x80222222); // 50% jet black
  static const Color textInverse = pureWhite;

  // ========== NEUTRAL GRAYS ==========
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF2F4F7);
  static const Color grey200 = Color(0xFFE4E7EC);
  static const Color grey300 = Color(0xFFD0D5DD);
  static const Color grey400 = Color(0xFF98A2B3);
  static const Color grey500 = Color(0xFF667085);
  static const Color grey600 = Color(0xFF475467);
  static const Color grey700 = Color(0xFF344054);
  static const Color grey800 = Color(0xFF1D2939);
  static const Color grey900 = Color(0xFF101828);

  // ========== GRADIENTS ==========
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [electricCyan, Color(0xFF00A3FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient taxiGradient = LinearGradient(
    colors: [goldenTaxiYellow, Color(0xFFFFB347)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [deepMidnightNavy, Color(0xFF151A33)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ========== SHADOWS ==========
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get neonGlow => [
        BoxShadow(
          color: electricCyan.withOpacity(0.5),
          blurRadius: 12,
          spreadRadius: 2,
        ),
      ];

  static List<BoxShadow> get buttonShadow => [
        BoxShadow(
          color: cyberYellow.withOpacity(0.3),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];
}