import 'package:flutter/material.dart';
class Config {
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.red,
    primaryColorLight: Colors.red,
    disabledColor: Colors.grey,
    inputDecorationTheme: InputDecorationTheme(
      border: Config().outlineInputBorder,
      errorBorder: Config().outlineInputBorder,
      enabledBorder:Config().outlineInputBorder,
      focusedBorder: Config().outlineInputBorder,
      disabledBorder: Config().outlineInputBorder,
      filled: true,
      fillColor: Colors.blueGrey.withAlpha(6),
      prefixIconColor: Colors.grey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 40, 20),
          disabledBackgroundColor: Colors.red.withAlpha(150),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4),
          ),
          ),
          textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500
          )
      ),
    ),
  );
  OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      )
  );
}