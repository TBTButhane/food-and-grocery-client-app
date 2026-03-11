// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you/account_page.dart';
import 'package:shop4you/cart_page.dart';
import 'package:shop4you/main_food_page.dart';
import 'package:shop4you/screens/order_page.dart';

import '../../Controllers/auth_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedPageIndex = 0;
  List pages = [
    FoodHomePage(),
    // HistoryScreen(),
    OrderPage(),
    CartPage(),
    AccountPage(),
  ];

  _onTapNav(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onTapNav,
          currentIndex: _selectedPageIndex,
          unselectedItemColor: Colors.green,
          selectedItemColor: Colors.green.shade900,
          showSelectedLabels: false,
          showUnselectedLabels: true,
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: "History"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: "cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Me"),
          ]),
    );
  }
}
