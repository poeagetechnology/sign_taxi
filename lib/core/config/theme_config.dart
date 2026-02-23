import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.cyberYellow,
      scaffoldBackgroundColor: AppColors.pureWhite,
      colorScheme: const ColorScheme.light(
        primary: AppColors.cyberYellow,
        secondary: AppColors.cyberYellow,
        surface: AppColors.pureWhite,
        error: AppColors.error,
        onPrimary: AppColors.jetBlack,
        onSecondary: AppColors.jetBlack,
        onSurface: AppColors.jetBlack,
        onError: AppColors.pureWhite,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.pureWhite,
        foregroundColor: AppColors.jetBlack,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.jetBlack,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.jetBlack),
        displayMedium: TextStyle(color: AppColors.jetBlack),
        displaySmall: TextStyle(color: AppColors.jetBlack),
        headlineMedium: TextStyle(color: AppColors.jetBlack),
        headlineSmall: TextStyle(color: AppColors.jetBlack),
        titleLarge: TextStyle(color: AppColors.jetBlack),
        titleMedium: TextStyle(color: AppColors.jetBlack),
        titleSmall: TextStyle(color: AppColors.spanishGrey),
        bodyLarge: TextStyle(color: AppColors.jetBlack),
        bodyMedium: TextStyle(color: AppColors.jetBlack),
        bodySmall: TextStyle(color: AppColors.spanishGrey),
        labelLarge: TextStyle(color: AppColors.jetBlack),
        labelMedium: TextStyle(color: AppColors.spanishGrey),
        labelSmall: TextStyle(color: AppColors.textDisabled),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cyberYellow,
          foregroundColor: AppColors.jetBlack,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.jetBlack,
          side: const BorderSide(color: AppColors.silverSand, width: 1),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.cyberYellow,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.pureWhite,
        hintStyle: const TextStyle(color: AppColors.spanishGrey),
        labelStyle: const TextStyle(color: AppColors.spanishGrey),
        prefixIconColor: AppColors.spanishGrey,
        suffixIconColor: AppColors.spanishGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.silverSand),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.silverSand),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cyberYellow, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      cardTheme: CardThemeData(
        color: AppColors.pureWhite,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.silverSand,
        thickness: 1,
        space: 1,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.cyberYellow,
        circularTrackColor: AppColors.silverSand,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.cyberYellow;
          }
          return AppColors.pureWhite;
        }),
        checkColor: WidgetStateProperty.all(AppColors.jetBlack),
        side: const BorderSide(color: AppColors.silverSand),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.pureWhite,
        selectedItemColor: AppColors.cyberYellow,
        unselectedItemColor: AppColors.spanishGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.cyberYellow,
        foregroundColor: AppColors.jetBlack,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.silverSand,
        disabledColor: AppColors.silverSand.withOpacity(0.5),
        selectedColor: AppColors.cyberYellow,
        secondarySelectedColor: AppColors.cyberYellow.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: const TextStyle(color: AppColors.jetBlack),
        secondaryLabelStyle: const TextStyle(color: AppColors.jetBlack),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.cyberYellow,
        inactiveTrackColor: AppColors.silverSand,
        thumbColor: AppColors.cyberYellow,
        overlayColor: AppColors.cyberYellow,
        valueIndicatorColor: AppColors.cyberYellow,
      ),
    );
  }

  // Optional dark theme – can be extended later
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.cyberYellow,
      scaffoldBackgroundColor: AppColors.deepMidnightNavy,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.cyberYellow,
        secondary: AppColors.cyberYellow,
        surface: AppColors.surfaceDark,
        error: AppColors.error,
        onPrimary: AppColors.jetBlack,
        onSecondary: AppColors.jetBlack,
        onSurface: AppColors.pureWhite,
        onError: AppColors.pureWhite,
      ),
      // Customize dark theme as needed
    );
  }
}