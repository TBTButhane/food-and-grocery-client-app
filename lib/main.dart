import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop4you/Controllers/auth_controller.dart';
import 'package:shop4you/Controllers/cart_controller.dart';
import 'package:shop4you/routes/route_helper.dart';
import 'util/dependencies.dart' as dep;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  Future<void> requestPermision() async {
    late bool _serviceEnabled;
    late LocationPermission _locationPermissionermissionGranted;
    // final Location location = Location();

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await Geolocator.openLocationSettings();
    }
    _locationPermissionermissionGranted = await Geolocator.checkPermission();
    if (_locationPermissionermissionGranted == LocationPermission.denied) {
      _locationPermissionermissionGranted = await Geolocator.requestPermission();
    }
    // _locationData = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    requestPermision();
    return
      GetBuilder<AuthController>(
    builder: (controller) =>
        GetMaterialApp(
      title: 'Shop 4 You',
      debugShowCheckedModeBanner: false,
      // theme: ThemeSwitcher.light,
      // darkTheme: ThemeSwitcher.dark,
      // themeMode: ThemeMode.light,
      // home: SignIn(),
      initialRoute: RouteHelper.getsplash(),
      getPages: RouteHelper.routes,
    )
    );
  }
}
