import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSwitcher extends GetxController {
  static final light = ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue,
      brightness: Brightness.light);
  static final dark =
      ThemeData(primaryColor: Colors.black, brightness: Brightness.dark);
}
