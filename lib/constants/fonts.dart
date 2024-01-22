import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle googleFonts(
    double fontSizes, Color fontColor, FontWeight fontWeights) {
  return GoogleFonts.kanit(
      color: fontColor, fontSize: fontSizes, fontWeight: fontWeights);
}
