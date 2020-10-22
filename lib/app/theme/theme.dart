import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Color(0xFF00ACC1),
  accentColor: Colors.blue,
  backgroundColor: Color(0xFFB2EBF2),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 0,
  ),
  cardTheme: CardTheme(
      elevation: 7,
      color: Colors.orange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), 
      // side: BorderSide(color: Color(0xFF006064))
      )),
  dividerColor: Colors.transparent
);

// COR CINZA DESTAQUE 0XFFF2F5F9