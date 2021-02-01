import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appThemeData = ThemeData(
    primaryColor: Color(0xFF546E7A),
    backgroundColor: Color(0xFFB2EBF2),
    scaffoldBackgroundColor: Colors.white,
    primaryTextTheme: GoogleFonts.mcLarenTextTheme(),
    cardTheme: CardTheme(
        elevation: 7,
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          // side: BorderSide(color: Color(0xFF006064))
        )),
    textTheme: GoogleFonts.mcLarenTextTheme(),
    dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
      color: Color(0xFF546E7A),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    )),
    dividerColor: Colors.transparent);

// COR CINZA DESTAQUE 0XFFF2F5F9
