// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop4you/widgets/dimentions.dart';

class AppIconAndText extends StatelessWidget {
  final IconData icon;
  final String text;
  final double? iconSize;
  final double? fontSize;
  final double? size;
  final Color? iconColr;
  final Color? fontColr;
  final Color? backgroundColor;

  const AppIconAndText(
      {Key? key,
      required this.icon,
      required this.text,
      this.iconSize,
      this.fontSize,
      this.size = 20,
      this.iconColr,
      this.fontColr,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimensions.width10,
        right: Dimensions.width10,
        top: Dimensions.height10 - 2,
        bottom: Dimensions.height10 - 2,
      ),
      // decoration: BoxDecoration(color: Colors.white, boxShadow: [
      //   BoxShadow(
      //       blurRadius: 1,
      //       offset: Offset(0, 2),
      //       color: Colors.grey.withOpacity(0.2))
      // ]),
      child: Row(
        children: [
          Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size! / 2),
                  color: backgroundColor),
              child: Icon(icon, size: iconSize, color: iconColr)),
          SizedBox(width: 10),
          Text(text,
              style: GoogleFonts.roboto(color: fontColr, fontSize: fontSize))
        ],
      ),
    );
  }
}
