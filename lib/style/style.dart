import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class PrimaryText extends StatelessWidget {
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final double height;

  const PrimaryText({
    required this.text,
    this.fontWeight: FontWeight.w400,
    this.color: AppColors.primary,
    this.size: 20,
    this.height: 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: color,
          height: height,
          fontFamily: 'Poppins',
          fontSize: size,
          fontWeight: fontWeight,
        ),);
  }
}

class AppFonts {
  static TextStyle content = GoogleFonts.ubuntu(
    fontSize: 14,
    color: Colors.grey[900],
    fontWeight: FontWeight.normal,
  );
  static TextStyle title = GoogleFonts.montserrat(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle interestTag = GoogleFonts.ubuntu(
    color: Colors.lightBlue,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle description = GoogleFonts.catamaran(
    fontSize: 14,
    color: Colors.grey[900],
    fontWeight: FontWeight.normal,
  );
  static TextStyle author = GoogleFonts.catamaran(
    fontSize: 12,
    color: Colors.grey[900],
    fontWeight: FontWeight.normal,
  );
  static TextStyle category = GoogleFonts.roboto(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
  static TextStyle headStyle = GoogleFonts.robotoSlab(
    fontSize: 22,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}