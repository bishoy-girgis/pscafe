import 'package:flutter/material.dart';
import 'package:ps_system/shared_components/constants.dart';

class MyTheme {
  static ThemeData LightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        toolbarHeight: 90,
        elevation: 1,
        color: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
        ),
      ),
      textTheme:  TextTheme(
        headlineMedium: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyMedium: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
          bodySmall: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        displayLarge:  TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
        displayMedium:  TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: pagee,
        ),

      ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: primaryColor,
        elevation: 0,
        selectedIconTheme: IconThemeData(color: Colors.white, size: 34),
        unselectedIconTheme:
        const IconThemeData(color: Color(0XFFC8C9CB), size: 32),
        selectedItemColor: Colors.white),
  );
}
