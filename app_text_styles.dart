import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography system: Cinzel for dramatic display headings (mirrors the
/// website's serif branding), Inter for everything readable.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle display(Color color) => GoogleFonts.cinzel(
        fontSize: 44,
        fontWeight: FontWeight.w900,
        color: color,
        letterSpacing: 1.5,
        height: 1.0,
      );

  static TextStyle heading(Color color) => GoogleFonts.cinzel(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 1,
      );

  static TextStyle subHeading(Color color) => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 4,
      );

  static TextStyle cardTitle(Color color) => GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w800,
        color: color,
      );

  static TextStyle body(Color color) => GoogleFonts.inter(
        fontSize: 14.5,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.55,
      );

  static TextStyle button(Color color) => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 1.6,
      );

  static TextStyle caption(Color color) => GoogleFonts.inter(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 1.2,
      );
}
