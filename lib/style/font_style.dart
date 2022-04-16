import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
  );
}

TextStyle get bodyStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
  );
}

TextStyle get body2Style {
  return GoogleFonts.lato(
    textStyle: TextStyle(color: Colors.grey[200], fontSize: 14, fontWeight: FontWeight.w400),
  );
}