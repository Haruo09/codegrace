import 'package:flutter/material.dart';

/// Paleta de Cores Catppuccin Mocha adaptada para o CodeGrace
class CatppuccinColors {
  static const Color mauve = Color(0xFFCBA6F7); // Cor Principal (Primary)
  static const Color lavender = Color(0xFFB4BEFE); // Cor Secundária (Secondary)
  static const Color yellow = Color(
    0xFFF9E2AF,
  ); // Destaque / Contraste (Accent)
  static const Color base = Color(0xFF1E1E2E); // Fundo Principal (Background)
  static const Color mantle = Color(0xFF181825); // Fundo Secundário
  static const Color surface0 = Color(0xFF313244); // Cards / Containers
  static const Color surface1 = Color(0xFF45475A); // Bordas e Divisores
  static const Color text = Color(0xFFCDD6F4); // Texto Principal
  static const Color subtext0 = Color(0xFFA6ADC8); // Texto Secundário
  static const Color green = Color(0xFFA6E3A1); // Sucesso / Resposta Correta
  static const Color red = Color(0xFFF38BA8); // Erro / Resposta Incorreta
}

class CatppuccinTheme {
  static ThemeData get mochaTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: CatppuccinColors.base,
      colorScheme: const ColorScheme.dark(
        primary: CatppuccinColors.mauve,
        secondary: CatppuccinColors.lavender,
        tertiary: CatppuccinColors.yellow,
        surface: CatppuccinColors.surface0,
        onPrimary: CatppuccinColors.base,
        onSecondary: CatppuccinColors.base,
        onSurface: CatppuccinColors.text,
        error: CatppuccinColors.red,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: CatppuccinColors.mantle,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: CatppuccinColors.mauve),
        titleTextStyle: TextStyle(
          color: CatppuccinColors.text,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: CatppuccinColors.surface0,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: CatppuccinColors.surface1, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: CatppuccinColors.mauve,
          foregroundColor: CatppuccinColors.base,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: CatppuccinColors.text,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        titleLarge: TextStyle(
          color: CatppuccinColors.text,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        bodyLarge: TextStyle(color: CatppuccinColors.text, fontSize: 16),
        bodyMedium: TextStyle(color: CatppuccinColors.subtext0, fontSize: 14),
      ),
    );
  }
}
