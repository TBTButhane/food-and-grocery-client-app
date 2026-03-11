// ignore_for_file: prefer_const_constructors

// import 'dart:convert';

import 'package:get/get.dart';
import 'package:shop4you/cart_page.dart';
import 'package:shop4you/models/order_model.dart';
import 'package:shop4you/models/place_order_model.dart';
// import 'package:shop4you/models/restaurant_model.dart';
import 'package:shop4you/screens/Auth/sign_in.dart';
import 'package:shop4you/screens/Auth/sign_up.dart';
import 'package:shop4you/screens/address_page.dart';
import 'package:shop4you/screens/home/home_page.dart';
import 'package:shop4you/screens/order_status_screen.dart';
import 'package:shop4you/screens/payment_screen.dart';
import 'package:shop4you/screens/single_res_screen.dart';
import 'package:shop4you/splash/splash_page.dart';
import 'package:shop4you/popular_food_detail_page.dart';
import 'package:shop4you/recommended_foodDetail_page.dart';
import 'package:shop4you/view_restaurents.dart';

import '../screens/pick_address_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splash = "/splash";
  static const String popularFoodPage = "/popular-food";
  static const String recommendedFoodPage = "/recommended-food";
  static const String viewAllRestuarants = "/all-Resturants";
  static const String cartPage = "/cart-page";
  static const String addressPage = "/address-page";
  static const String pickAddress = "/pick-address-page";
  static const String signIn = "/signIn";
  static const String register = "/register";
  static const String paymentPage = "/paymentPage";
  static const String orderStatusPage = "/orderStatusPage";
  static const String singleResScreen = "/singleResScreen";

  //Best practise is to call this pages like a method, so that we can pass arguments to the page
  // eg static string getPopularFood()=>'$popularFoodPage';

  static String getIntialPage() => initial;
  static String getsplash() => splash;

  static String getPopularFood(
    int pageId,
    String page,
  ) =>
      '$popularFoodPage?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFoodPage?pageId=$pageId&page=$page';
  static String getViewAllRestuarants() => viewAllRestuarants;
  static String getCartPagge(String page) => '$cartPage?page=$page';
  static String getAddress(String page) => '$addressPage?page=$page';
  static String pickAddressPage() => pickAddress;
  static String getSignInPage() => signIn;
  static String getSingleResScreen()=>singleResScreen;
  static String getRegisterPage() => register;
  static String getPaymentPage(
          {String? orderId, String? userId, String? placeOrderModel}) =>
      '$paymentPage?orderId=$orderId&userId=$userId&placeOrderModel=$placeOrderModel';
  static String getOrderStatusPage({String? boolValue}) =>
      '$orderStatusPage?boolValue=$boolValue';

  static List<GetPage> routes = [
    GetPage(
        name: initial, page: () => HomePage(), transition: Transition.fadeIn),
    GetPage(
      name: splash,
      page: () => SplashPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: popularFoodPage,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];

          return PopularFood(
            pageId: int.parse(pageId!),
            page: page!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFoodPage,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return Recommended_FoodDetails_Page(
              pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: viewAllRestuarants,
        page: () => AllRestaurents(),
        transition: Transition.fadeIn),
    GetPage(
        name: singleResScreen,
        
        page: () { 
          //  RestaurantsModel  resModel = jsonDecode(Get.parameters['resModel']!);
          //  List<dynamic> productList1 = Get.parameters['productList']!.split("");
         
          return SingleResScreen(
       
          // productList: [],
          // restaurant: resModel,
        );},
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          var page = Get.parameters['page'];
          return CartPage(
            page: page,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: addressPage,
        page: () {
          var page = Get.parameters['page'];
          return AddressPage(page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: pickAddress,
        page: () {
          PickAddressPage _pickAddressPage = Get.arguments;
          return _pickAddressPage;
        },
        transition: Transition.fadeIn),
    GetPage(name: signIn, page: () => SignIn(), transition: Transition.fadeIn),
    GetPage(
        name: register, page: () => SignUp(), transition: Transition.fadeIn),
    GetPage(
        name: paymentPage,
        arguments: PlaceOrderModel,
        page: () {
          return PaymentScreen(
              orderModel: OrderModel(
                  id: Get.parameters['orderId']!,
                  userId: Get.parameters['userId']!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: orderStatusPage,
        arguments: OrderModel,
        page: () {
          return OrderStatusScreen(
            boolValue: Get.parameters['boolValue'],
          );
        },
        transition: Transition.fadeIn),
  ];
}
