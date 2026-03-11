import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigText extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool isBold;
  final Color fontColor;
  const BigText(
      {Key? key,
      required this.text,
      this.fontSize = 25,
      this.isBold = false,
      this.fontColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.domine(
          color: fontColor,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: fontSize),
    );
  }
}
