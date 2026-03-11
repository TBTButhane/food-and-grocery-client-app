import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you/widgets/big_text.dart';
import 'package:shop4you/widgets/dimentions.dart';
import 'package:shop4you/routes/route_helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  FirebaseAuth auth = FirebaseAuth.instance;
  late AnimationController animationController;

  @override
  void initState() {
    //LoadResources();TODO: load your getx dependencies

    super.initState();
    // User? user = auth.currentUser;
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..forward();
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);
    Timer(const Duration(seconds: 12), (() {
      Get.offNamed(RouteHelper.getIntialPage());
      // AuthController.instance.redirect(user);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Column(
              children: [
                Center(
                  child: Image(
                      image: const AssetImage(
                        "assets/images/shop4you.jpeg",
                      ),
                      fit: BoxFit.cover,
                      width: Dimensions.screenWidth),
                ),
                Center(
                    child: BigText(
                  text: "Powered by HostTree",
                  fontColor: Colors.black,
                  fontSize: Dimensions.font20,
                  isBold: true,
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
