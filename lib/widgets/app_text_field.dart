// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop4you/widgets/dimentions.dart';

class AppTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final double? textInputSize;
  final TextInputType type;
  final TextEditingController controller;
  final bool isPassword;
  bool maxLines;
  AppTextField(
      {Key? key,
      required this.icon,
      required this.hintText,
      this.textInputSize = 10,
      required this.controller,
      required this.type,
      this.isPassword = false,
      this.maxLines = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: textInputSize!),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius15 - 5),
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                spreadRadius: 7,
                offset: Offset(1, 15),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: TextField(
        autocorrect: true,
        keyboardType: type,
        controller: controller,
        maxLines: maxLines ? 3 : 1,
        obscureText: isPassword,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              icon,
              color: Colors.green,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  Dimensions.radius15,
                ),
                borderSide: BorderSide(width: 1.0, color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  Dimensions.radius15,
                ),
                borderSide: BorderSide(width: 1.0, color: Colors.white)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Dimensions.radius15,
              ),
            )),
      ),
    );
  }
}
