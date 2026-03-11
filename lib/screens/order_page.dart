// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you/Controllers/auth_controller.dart';
import 'package:shop4you/Controllers/payment_controller.dart';
import 'package:shop4you/routes/route_helper.dart';
import 'package:shop4you/screens/history_screen.dart';
import 'package:shop4you/widgets/big_text.dart';
import 'package:shop4you/widgets/custom_button.dart';
import 'package:shop4you/widgets/dimentions.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();

    if (_isLoggedIn) {
      _tabController = TabController(length: 3, vsync: this);
      if (Get.find<PaymentController>().currentOrderList.isEmpty ||
          Get.find<PaymentController>().historyOrderList.isEmpty) {
        Get.find<PaymentController>().userOrderList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("My orders"),
          backgroundColor: Colors.green,
          leading: SizedBox(),
        ),
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return GetBuilder<PaymentController>(builder: (paymentController) {
              {
                return authController.isLoggedIn()
                    ? Column(
                        children: [
                          Container(
                            width: Dimensions.screenWidth,
                            child: TabBar(
                              controller: _tabController,
                              indicatorColor: Colors.green,
                              indicatorWeight: 3,
                              labelColor: Colors.green,
                              unselectedLabelColor:
                                  Theme.of(context).disabledColor,
                              tabs: [
                                Tab(
                                  text: "Current orders",
                                ),
                                Tab(
                                  text: "Complete Orders",
                                ),
                                Tab(
                                  text: "Cart History",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    paymentController
                                        .currentOrderList.isEmpty
                                        ? Center(child:BigText(text:"You don't have any orders", fontSize: Dimensions.font20))
                                        : SizedBox(
                                        width: Dimensions.screenWidth,
                                        child: ListView.builder(
                                            itemCount:  paymentController
                                                    .currentOrderList.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: InkWell(
                                                  onTap: () {

                                                  },
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "Order ID ${paymentController.currentOrderList[index].id}"),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          Dimensions
                                                                              .width15,
                                                                      vertical:
                                                                          Dimensions
                                                                              .height10),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .green,
                                                                      borderRadius:
                                                                          BorderRadius.circular(Dimensions.radius20 /
                                                                              4)),
                                                                  child:
                                                                      BigText(
                                                                    text:
                                                                        "${paymentController.currentOrderList[index].orderStatus}",
                                                                    fontColor:
                                                                        Colors
                                                                            .white,
                                                                    isBold:
                                                                        false,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .font16,
                                                                  )),
                                                              SizedBox(
                                                                  height: Dimensions
                                                                          .height10 -
                                                                      3),
                                                              InkWell(
                                                                onTap: () {

                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          Dimensions
                                                                              .width15,
                                                                      vertical:
                                                                          Dimensions
                                                                              .height10),
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .green,
                                                                          width:
                                                                              1),
                                                                      borderRadius:
                                                                          BorderRadius.circular(Dimensions.radius20 /
                                                                              4)),
                                                                  child:
                                                                      BigText(
                                                                    text:
                                                                        "Track order",
                                                                    fontColor:
                                                                        Colors
                                                                            .black,
                                                                    isBold:
                                                                        false,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .font16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .height10),
                                                      Divider(
                                                        color: Colors.green,
                                                        thickness: 1,
                                                        indent: Dimensions
                                                                .width30 +
                                                            Dimensions.width30,
                                                        endIndent: Dimensions
                                                                .width30 +
                                                            Dimensions.width30,
                                                        height: 1,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })),
                                    paymentController
                                        .historyOrderList.isEmpty
                                        ? Center(child:BigText(text:"You have no completed orders", fontSize: Dimensions.font20))
                                        :SizedBox(
                                        width: Dimensions.screenWidth,
                                        child: ListView.builder(
                                            itemCount: paymentController
                                                .historyOrderList.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: InkWell(
                                                  onTap: () {

                                                  },
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "Order ID ${paymentController.historyOrderList[index].id}"),
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                      Dimensions
                                                                          .width15,
                                                                      vertical:
                                                                      Dimensions
                                                                          .height10),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .green,
                                                                      borderRadius:
                                                                      BorderRadius.circular(Dimensions.radius20 /
                                                                          4)),
                                                                  child:
                                                                  BigText(
                                                                    text:
                                                                    "${paymentController.historyOrderList[index].orderStatus}",
                                                                    fontColor:
                                                                    Colors
                                                                        .white,
                                                                    isBold:
                                                                    false,
                                                                    fontSize:
                                                                    Dimensions
                                                                        .font16,
                                                                  )),
                                                              SizedBox(
                                                                  height: Dimensions
                                                                      .height10 -
                                                                      3),
                                                              InkWell(
                                                                onTap: () {

                                                                },
                                                                child:
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                      Dimensions
                                                                          .width15,
                                                                      vertical:
                                                                      Dimensions
                                                                          .height10),
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .green,
                                                                          width:
                                                                          1),
                                                                      borderRadius:
                                                                      BorderRadius.circular(Dimensions.radius20 /
                                                                          4)),
                                                                  child:
                                                                  BigText(
                                                                    text:
                                                                    "Track order",
                                                                    fontColor:
                                                                    Colors
                                                                        .black,
                                                                    isBold:
                                                                    false,
                                                                    fontSize:
                                                                    Dimensions
                                                                        .font16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .height10),
                                                      Divider(
                                                        color: Colors.green,
                                                        thickness: 1,
                                                        indent: Dimensions
                                                            .width30 +
                                                            Dimensions.width30,
                                                        endIndent: Dimensions
                                                            .width30 +
                                                            Dimensions.width30,
                                                        height: 1,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })),
                                    HistoryScreen(),
                                  ]),
                            ),
                          )
                        ],
                      )
                    : SizedBox(
                        width: Dimensions.screenWidth,
                        height: Dimensions.screenHeight,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BigText(
                                text:
                                    "Sign in to view history and Pending orders",
                                isBold: true,
                                fontSize: Dimensions.font16 + 2,
                                fontColor: Colors.green,
                              ),
                              SizedBox(
                                height: Dimensions.height30,
                              ),
                              CustomButton(
                                buttonText: "Sign in",
                                fontSize: Dimensions.font16,
                                height: Dimensions.height45 + 10,
                                width: Dimensions.screenWidth,
                                onPressed: () {
                                  Get.offNamed(RouteHelper.getSignInPage());
                                },
                                icon: Icons.login_rounded,
                              )
                            ],
                          ),
                        ),
                      );
              }
            });
          },
        ));
  }
}
