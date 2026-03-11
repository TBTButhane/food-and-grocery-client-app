import 'package:get/get.dart';
import 'package:shop4you/Controllers/auth_controller.dart';
import 'package:shop4you/Controllers/cart_controller.dart';
import 'package:shop4you/Controllers/location_controller.dart';
import 'package:shop4you/Controllers/payment_controller.dart';
import 'package:shop4you/Controllers/product_controller.dart';
import 'package:shop4you/util/apiClient.dart';
import 'package:shop4you/util/cart_repo.dart';
import 'package:shop4you/util/location_repo.dart';
import 'package:shop4you/util/payment_repo.dart';
import 'package:shop4you/util/popular_repo.dart';
import 'package:shop4you/util/recommended_repo.dart';
import 'package:shop4you/util/user_details_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/notification_controller.dart';

Future<void> init() async {
  final getStorage = await SharedPreferences.getInstance();
  Get.lazyPut(() => getStorage, fenix: true);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: "https://maps.googleapis.com"),
      fenix: true);
  // Get.lazyPut(
  //     () => ApiClient(appBaseUrl: "http://127.0.0.1:8000/api/v1/products/"));
  //repos
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => RecommendedRepo(apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => CartRepo(getStorage: Get.find()), fenix: true);
  Get.lazyPut(() => UserDetailRepo(getStorage: Get.find()), fenix: true);
  Get.lazyPut(() => PaymentRepo(apiClient: Get.find()), fenix: true);
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()),
      fenix: true);

//Controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()),
      fenix: true);
  Get.lazyPut(() => AuthController(userDetailRepo: Get.find()), fenix: true);
  Get.lazyPut(() => LocationController(locationRepo: Get.find()), fenix: true);
  Get.lazyPut(() => PaymentController(paymentRepo: Get.find()), fenix: true);
  Get.lazyPut(() => NotificationController(), fenix: true);
  // Get.lazyPut(() => NotificationController(apiClient: Get.find()));
  // Get.lazyPut(
  //     () => RecommendedProductController(recommendedProductRepo: Get.find()));
  // Get.lazyPut(() => HomeScreenController());
  Get.lazyPut(() => CartController(cartRepo: Get.find()), fenix: true);
}
