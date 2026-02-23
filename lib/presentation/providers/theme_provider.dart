import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ThemeProvider extends ChangeNotifier {
  Map<String, dynamic>? _themeMap;
  ThemeData? _themeData;

  Map<String, dynamic> get themeMap => _themeMap ?? {};
  ThemeData? get themeData => _themeData;

  Future<void> loadTheme() async {
    try {
      final jsonString = await rootBundle.loadString('assets/theme.json');
      _themeMap = json.decode(jsonString);
    } catch (e) {
      print('Error loading theme: $e');
      _themeMap = _fallbackThemeMap();
    }
    _themeData = _buildThemeData();
    notifyListeners();
  }

  ThemeData _buildThemeData() {
    final colors = _themeMap!['colors'] as Map? ?? {};
    final spacing = _themeMap!['spacing'] as Map? ?? {};
    final borderRadius = _themeMap!['borderRadius'] as Map? ?? {};
    final typography = _themeMap!['typography'] as Map? ?? {};
    final fontSize = (typography['fontSize'] as Map?) ?? {};

    // Provide safe defaults for colors
    String getPrimaryColor() => colors['primary']?.toString() ?? '#1E3A8A';
    String getSecondaryColor() => colors['secondary']?.toString() ?? '#0891B2';
    String getBackgroundColor() =>
        colors['background']?.toString() ?? '#F8FAFC';
    String getSurfaceColor() => colors['surface']?.toString() ?? '#FFFFFF';
    String getTextPrimaryColor() =>
        colors['textPrimary']?.toString() ?? '#1E293B';
    String getErrorColor() => colors['error']?.toString() ?? '#EF4444';

    return ThemeData(
      primaryColor: _hexToColor(getPrimaryColor()),
      scaffoldBackgroundColor: _hexToColor(getBackgroundColor()),
      colorScheme: ColorScheme.light(
        primary: _hexToColor(getPrimaryColor()),
        secondary: _hexToColor(getSecondaryColor()),
        surface: _hexToColor(getSurfaceColor()),
        error: _hexToColor(getErrorColor()),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _hexToColor(getPrimaryColor()),
        foregroundColor: _hexToColor(getTextPrimaryColor()),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _hexToColor(getPrimaryColor()),
          foregroundColor: _hexToColor(getTextPrimaryColor()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              (borderRadius['md'] as num?)?.toDouble() ?? 8.0,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: (spacing['md'] as num?)?.toDouble() ?? 16.0,
            vertical: (spacing['sm'] as num?)?.toDouble() ?? 8.0,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            (borderRadius['sm'] as num?)?.toDouble() ?? 4.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _hexToColor(getPrimaryColor())),
        ),
        contentPadding: EdgeInsets.all(
          (spacing['md'] as num?)?.toDouble() ?? 16.0,
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: (fontSize['xxl'] as num?)?.toDouble() ?? 32.0,
          fontWeight: FontWeight.bold,
          color: _hexToColor(getTextPrimaryColor()),
        ),
        headlineMedium: TextStyle(
          fontSize: (fontSize['xl'] as num?)?.toDouble() ?? 24.0,
          fontWeight: FontWeight.bold,
          color: _hexToColor(getTextPrimaryColor()),
        ),
        bodyLarge: TextStyle(
          fontSize: (fontSize['md'] as num?)?.toDouble() ?? 16.0,
          color: _hexToColor(getTextPrimaryColor()),
        ),
        bodyMedium: TextStyle(
          fontSize: (fontSize['sm'] as num?)?.toDouble() ?? 14.0,
          color: _hexToColor(colors['textSecondary']?.toString() ?? '#64748B'),
        ),
      ),
    );
  }

  Color _hexToColor(String? hex) {
    if (hex == null || hex.isEmpty) {
      return Color(0xFF1E3A8A); // Default to primary blue
    }
    hex = hex.replaceFirst('#', '');
    try {
      return Color(int.parse('FF$hex', radix: 16));
    } catch (e) {
      print('Error parsing color: $hex, using default color');
      return Color(0xFF1E3A8A); // Default to primary blue
    }
  }

  Map<String, dynamic> _fallbackThemeMap() {
    return {
      "colors": {
        "primary": "#1E3A8A",
        "primaryDark": "#1E40AF",
        "primaryLight": "#3B82F6",
        "secondary": "#0891B2",
        "accent": "#06B6D4",
        "white": "#FFFFFF",
        "background": "#F8FAFC",
        "surface": "#FFFFFF",
        "surfaceVariant": "#F1F5F9",
        "border": "#E2E8F0",
        "textPrimary": "#1E293B",
        "textSecondary": "#64748B",
        "textDisabled": "#CBD5E1",
        "success": "#10B981",
        "error": "#EF4444",
        "warning": "#F59E0B",
        "info": "#3B82F6",
      },
      "spacing": {"xs": 4, "sm": 8, "md": 16, "lg": 24, "xl": 32, "xxl": 48},
      "typography": {
        "fontFamilyBase":
            "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif",
        "fontSize": {
          "xs": 12,
          "sm": 14,
          "md": 16,
          "lg": 18,
          "xl": 24,
          "xxl": 32,
        },
      },
      "borderRadius": {"sm": 4, "md": 8, "lg": 16, "xl": 24},
      "shadows": {
        "sm": "0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24)",
        "md": "0 4px 6px rgba(0,0,0,0.1)",
        "lg": "0 10px 25px rgba(0,0,0,0.1)",
      },
    };
  }
}
