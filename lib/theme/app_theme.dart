import 'package:flutter/material.dart';
import 'package:todo_list/helper/consts.dart';

class AppTheme {
  static ThemeData getTheme(bool isDark) {
    return ThemeData(
      scaffoldBackgroundColor:
          isDark ? darkPrimaryColor : lightPrimaryColor,

      appBarTheme: AppBarTheme(
        backgroundColor:
            isDark ? darkPrimaryColor : lightPrimaryColor,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: isDark ? Colors.white : primaryColor,
        indicatorColor: isDark ? Colors.white : primaryColor,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),

      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),

      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: isDark ? Colors.white : Colors.black,
        ),
      ),

      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    );
  }
}