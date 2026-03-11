// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop4you/widgets/dimentions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height20 * 5,
      width: Dimensions.height20 * 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20 * 5 / 2),
          color: Colors.green),
      alignment: Alignment.center,
      child: CircularProgressIndicator(color: Colors.white),
    );
  }
}
