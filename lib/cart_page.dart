// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop4you/Controllers/auth_controller.dart';
import 'package:shop4you/Controllers/location_controller.dart';
import 'package:shop4you/Controllers/payment_controller.dart';
import 'package:shop4you/Controllers/product_controller.dart';
import 'package:shop4you/models/place_order_model.dart';
import 'package:shop4you/routes/route_helper.dart';
import 'package:shop4you/widgets/app_text_field.dart';
import 'package:shop4you/widgets/big_text.dart';
import 'package:shop4you/widgets/custom_pay_method_selecter.dart';
import 'package:shop4you/widgets/custome_snackbar.dart';
import 'package:shop4you/widgets/delivery_options_btn.dart';
import 'package:shop4you/widgets/dimentions.dart';
import 'package:shop4you/widgets/appicon.dart';
import 'package:shop4you/widgets/no_data_page.dart';
import 'package:shop4you/models/order_model.dart';
import 'Controllers/cart_controller.dart';
import '../models/address_model.dart';

class CartPage extends StatefulWidget {
  final String? page;
  const CartPage({Key? key, this.page}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late OrderModel orderModel;
  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>();
    return Scaffold(
        backgroundColor: Color(0xFFF1F1F1),
        appBar:widget.page != 'cart'
            ?AppBar(
          centerTitle:true,
          backgroundColor: Colors.green,
          title: BigText(text:"Cart Page", fontSize:20, isBold:true, fontColor:Colors.white),
        ): PreferredSize( preferredSize: Size.fromHeight(Dimensions.height45+15),

            child: customAppBar()),
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.height20,
                left: Dimensions.width10 + 5,
                right: Dimensions.width10 + 5,
                bottom: 0,
                child: Container(
                  color: Color(0xFFF1F1F1),
                  margin: EdgeInsets.only(
                    top: Dimensions.height15,
                  ),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                      builder: (cartController) {
                        var _cartList = cartController.getItems;
                        return _cartList.isNotEmpty
                            ? ListView.separated(
                                separatorBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Divider(
                                      color: Colors.grey.shade200,
                                      thickness: 1,
                                      height: 1,
                                    ),
                                  );
                                },
                                // itemCount: cartController.getItems.length,
                                itemCount: _cartList.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: Dimensions.height20 * 5,
                                    width: double.maxFinite,
                                    child: GestureDetector(
                                      onTap: () {
                                        var popularIndex =
                                            Get.find<PopularProductController>()
                                                .getproductsList
                                                .indexOf(
                                                    _cartList[index].product);
                                        if (popularIndex >= 0) {
                                          //TODO: add page index for both routes
                                          Get.toNamed(
                                              RouteHelper.getPopularFood(
                                                  popularIndex, "cartpage"));
                                          //  Get.toNamed(
                                          // RouteHelper.getPopularFood(popularIndex, "cartPage"));
                                        } else {
                                          //TODO: create Recommendedcontroller, repo and page index
                                          var recommendedIndex = Get.find<
                                                  PopularProductController>()
                                              .getproductsList
                                              .indexOf(_cartList[index]);
                                          if (recommendedIndex < 0) {
                                            Get.snackbar("History Product",
                                                "Product review is not available for history product",
                                                backgroundColor: Colors.green,
                                                colorText: Colors.white);
                                          } else {
                                            Get.toNamed(
                                                RouteHelper.getRecommendedFood(
                                                    recommendedIndex,
                                                    "cartPage"));
                                          }
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            width: Dimensions.height20 * 5,
                                            height: Dimensions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      _cartList[index]
                                                          .image
                                                          .toString()),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20),
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: Dimensions.width10,
                                          ),
                                          Expanded(
                                              child: Container(
                                            height: Dimensions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(_cartList[index].name!,
                                                    style: TextStyle(
                                                        fontSize:
                                                            Dimensions.font20,
                                                        color: Colors.black)),
                                                _cartList[index]
                                                            .product!
                                                            .restaurantsModel!
                                                            .name !=
                                                        null
                                                    ? Text(
                                                        _cartList[index]
                                                            .product!
                                                            .restaurantsModel!
                                                            .name
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: Dimensions
                                                                .font16,
                                                            color:
                                                                Colors.black))
                                                    : SizedBox(),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "R ${_cartList[index].price}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font20,
                                                              color:
                                                                  Colors.red)),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: Dimensions
                                                              .height10,
                                                          bottom: Dimensions
                                                              .height10,
                                                        ),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radius20),
                                                            color:
                                                                Colors.white),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    -1);
                                                              },
                                                              child: AppIcon(
                                                                icon: Icons
                                                                    .remove,
                                                                size: 30,
                                                                iconSize: 25,
                                                              ),
                                                            ),
                                                            SizedBox(width: 3),
                                                            Text(
                                                                _cartList[index]
                                                                    .quantity
                                                                    .toString(),
                                                                style: GoogleFonts.roboto(
                                                                    color: Colors
                                                                        .black45,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        20)),
                                                            SizedBox(width: 3),
                                                            GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    1);
                                                              },
                                                              child: AppIcon(
                                                                icon: Icons.add,
                                                                size: 30,
                                                                iconSize: 25,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : NoDataPage(
                                imagelink: "assets/images/empty-cart (1).png",
                                imageText: "No Items in cart",
                              );
                      },
                    ),
                  ),
                ))
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return GetBuilder<PaymentController>(builder: (paymentController) {
              _noteController.text = paymentController.footNote;
              return Container(
                  height: (Dimensions.height45 * 2.7) + Dimensions.height30,
                  padding: EdgeInsets.only(
                      top: Dimensions.height10,
                      left: Dimensions.width15,
                      right: Dimensions.width15,
                      bottom: Dimensions.height10),
                  decoration: BoxDecoration(
                      color: cartController.getItems.isNotEmpty
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: cartController.getItems.isNotEmpty
                      ? Column(
                          children: [
                            InkWell(
                                onTap: () => showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (_) {
                                          return SingleChildScrollView(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1.1,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        Dimensions.radius20),
                                                    topRight: Radius.circular(
                                                        Dimensions.radius20),
                                                  ),
                                                  color: Colors.white),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomPayMethodSelecter(
                                                    index: 0,
                                                    leadingIcon: Icons.money,
                                                    paymentTitle:
                                                        "Cash on Delivery",
                                                    subtitle:
                                                        "Pay only on delivered orders",
                                                    trallingIcon:
                                                        Icons.check_circle,
                                                  ),
                                                  CustomPayMethodSelecter(
                                                    index: 1,
                                                    leadingIcon: Icons.payment,
                                                    paymentTitle:
                                                        "Digital Payment",
                                                    subtitle:
                                                        "The safest way to make payment",
                                                    trallingIcon:
                                                        Icons.check_circle,
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: Dimensions
                                                              .width10),
                                                      child: BigText(
                                                        text:
                                                            "Delivery options:",
                                                        fontColor: Colors.green,
                                                        isBold: true,
                                                        fontSize:
                                                            Dimensions.font20,
                                                      )),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.height10 / 2,
                                                  ),
                                                  DeliveryOptionsButtons(
                                                    value: 'delivery',
                                                    amount: paymentController
                                                        .deliveryAmount
                                                        .toDouble(),
                                                    title: "Home Delivery",
                                                    isFree: false,
                                                  ),
                                                  // SizedBox(
                                                  //   height: Dimensions.height10 / 2,
                                                  // ),
                                                  DeliveryOptionsButtons(
                                                    value: 'take away',
                                                    amount: Get.find<
                                                            CartController>()
                                                        .totalAmount
                                                        .toDouble(),
                                                    title: "Take Away",
                                                    isFree: true,
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: Dimensions
                                                              .width10),
                                                      child: BigText(
                                                        text:
                                                            "Additional Notes:",
                                                        fontColor: Colors.green,
                                                        isBold: true,
                                                        fontSize:
                                                            Dimensions.font20,
                                                      )),
                                                  AppTextField(
                                                      icon: Icons.note,
                                                      maxLines: true,
                                                      hintText:
                                                          "Additional Order notes",
                                                      controller:
                                                          _noteController,
                                                      type: TextInputType
                                                          .multiline)
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                    .whenComplete(() =>
                                        paymentController.setFoodNote(
                                            _noteController.text.trim())),
                                child: Container(
                                  height:
                                      Dimensions.height45 + Dimensions.height15,
                                  width: double.maxFinite,
                                  padding: EdgeInsets.only(
                                      top: Dimensions.height15,
                                      bottom: Dimensions.height15,
                                      left: Dimensions.width15,
                                      right: Dimensions.width15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.green),
                                  child: Center(
                                    child: Text("Payment options",
                                        style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: Dimensions.font20)),
                                  ),
                                )),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // height: 50,
                                  padding: EdgeInsets.only(
                                    top: Dimensions.height10,
                                    left: Dimensions.width20,
                                    right: Dimensions.width20,
                                    bottom: Dimensions.height10,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.green),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: Dimensions.width10 / 2,
                                      ),
                                      Text(
                                          paymentController.orderType ==
                                                  "delivery"
                                              ? "R ${cartController.totalAmount + paymentController.deliveryAmount}"
                                              : "R ${cartController.totalAmount}",
                                          style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20)),
                                      SizedBox(
                                        width: Dimensions.width10 / 2,
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (Get.find<AuthController>()
                                        .isLoggedIn()) {
                                      if (Get.find<LocationController>()
                                          .addressList
                                          .isEmpty) {
                                        Get.toNamed(RouteHelper.getAddress(
                                            "cart page"));
                                      } else {
                                        // Go to payment page

                                        // cartController.addtoHistory();

                                        var location =
                                            Get.find<LocationController>()
                                                .getUserAddress();
                                        var cart =
                                            Get.find<CartController>().getItems;
                                        var user = Get.find<AuthController>()
                                            .storedUserDetails;
                                        PlaceOrderModel placeOrder = PlaceOrderModel(
                                            cart: cart,
                                            orderAmount: paymentController
                                                        .orderType ==
                                                    "delivery"
                                                ? cartController.totalAmount
                                                        .toDouble() +
                                                    paymentController
                                                        .deliveryAmount
                                                        .toDouble()
                                                : cartController.totalAmount
                                                    .toDouble(),
                                            orderNote:
                                                paymentController.footNote,
                                            distance: 10.0,
                                            scheduleAt: "",
                                            orderType:
                                                paymentController.orderType,
                                            paymentMethod: paymentController
                                                        .paymentIndex ==
                                                    0
                                                ? 'cash_on_delivery'
                                                : 'Digital_payment',
                                            address: location.address,
                                            longitude: location.longitude,
                                            latitude: location.latitude,
                                            contactPersonName: user!.name,
                                            contactPersonEmail: user.email,
                                            contactPersonNumber:
                                                user.phoneNumber);

                                        String jsonData = toJson(placeOrder);

                                        // Get.find<PaymentController>()
                                        //     .placeOrder(placeOrder, _callback);

                                        //GenerateOrderNumber
                                        FirebaseAuth _auth =
                                            FirebaseAuth.instance;
                                        double orderNumber =
                                            await Get.find<PaymentController>()
                                                .generateOrdersNumber();

                                        if (paymentController.paymentIndex ==
                                            0) {
                                          bool _isSuccess = true;
                                          placeOrder.scheduleAt =
                                              DateTime.now().toString();
                                          orderModel = OrderModel(
                                            id: "${orderNumber.toInt()}",
                                            userId: _auth.currentUser!.uid,
                                            placeOrderDetails: placeOrder,
                                            deliveryAddress: AddressModel(
                                              addressType: 'Home',
                                              latitude: placeOrder.latitude,
                                              address: placeOrder.address,
                                              contactNumber: placeOrder
                                                  .contactPersonNumber,
                                              contactPerson:
                                                  placeOrder.contactPersonName,
                                              longitude: placeOrder.longitude,
                                            ),
                                            scheduledAt: placeOrder.scheduleAt,
                                            orderStatus: "pending",
                                            createdAt:
                                                DateTime.now().toString(),
                                            orderAmount: paymentController
                                                        .paymentIndex ==
                                                    0
                                                ? (placeOrder.orderAmount! +
                                                    paymentController
                                                        .deliveryAmount
                                                        .toDouble())
                                                : placeOrder.orderAmount,
                                            orderNote: placeOrder.orderNote,
                                            paymentStatus:
                                                placeOrder.paymentMethod,
                                          );

                                          Get.find<CartController>()
                                              .addtoHistory();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .removeCartSharedPreference();

                                          Get.offNamed(
                                              arguments: orderModel,
                                              RouteHelper.getOrderStatusPage(
                                                  boolValue:
                                                      _isSuccess.toString()));
                                        } else {
                                          Get.toNamed(
                                            arguments: placeOrder,
                                            RouteHelper.getPaymentPage(
                                                orderId:
                                                    "${orderNumber.toInt()}",
                                                userId: _auth.currentUser!.uid,
                                                placeOrderModel: jsonData),
                                          );
                                        }
                                      }
                                    } else {
                                      shoeCustomSnackbar(
                                          "Please sign in first...",
                                          title: "Sign-in");
                                      Get.toNamed(RouteHelper.getSignInPage());
                                    }
                                  },
                                  child: Container(
                                    height: Dimensions.height45 +
                                        Dimensions.height15,
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height20,
                                        // bottom: Dimensions.height20,
                                        left: Dimensions.width15,
                                        right: Dimensions.width15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.green),
                                    child: Text("Check Out",
                                        style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      : SizedBox());
            });
          },
        ));
  }

  Widget customAppBar(){
    return Stack(
      children: [
        Positioned(
            top:  Dimensions.height45 ,
            left: Dimensions.width20,
            right:Dimensions.width20,
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                GestureDetector(
                  onTap: () {
                    //TODO: Add link to the previous page
                    // widget.page="";
                    Get.back();
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios_new,
                    iconColor: Colors.white,
                    backgroundColor: Colors.green,
                    iconSize: Dimensions.iconSize24+12,
                    size: Dimensions.iconSize24 + 16,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAndToNamed(RouteHelper.initial);
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: Colors.green,
                    iconSize: Dimensions.iconSize24+12,
                    size: Dimensions.iconSize24 + 16,
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     //TODO: Add link to the cart page
                //   },
                //   child: AppIcon(
                //     icon: Icons.shopping_cart_outlined,
                //     iconColor: Colors.white,
                //     backgroundColor: Colors.green,
                //     iconSize: 30,
                //     size: Dimensions.iconSize24 + 11,
                //   ),
                // )
              ],
            )),
      ],
    );
  }

  void _callback(bool isSuccess, String message, String orderId) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addtoHistory();

      //TODO: Change id and userID to corresponding user data
      Get.offNamed(
          // arguments: placeOrder,
          RouteHelper.getPaymentPage(
              orderId: orderId,
              userId: Get.find<AuthController>().auth.currentUser!.uid));
    } else {
      shoeCustomSnackbar(message);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
