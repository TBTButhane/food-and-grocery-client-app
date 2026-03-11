// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shop4you/Controllers/cart_controller.dart';
import 'package:shop4you/models/cart_model.dart';
import 'package:shop4you/routes/route_helper.dart';
// import 'package:shop4you/widgets/appicon.dart';
import 'package:shop4you/widgets/dimentions.dart';
import 'package:shop4you/widgets/no_data_page.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    var cartHistory =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    // for (var element in cartHistory) {
    //   if (cartItemsPerOrder.containsKey(cartHistory[element.id!].time)) {
    //     cartItemsPerOrder.update(
    //         cartHistory[element.id!].toString(), (value) => ++value);
    //   } else {
    //     cartItemsPerOrder.putIfAbsent(element.time!, () => 1);
    //   }
    // }
    for (var i = 0; i < cartHistory.length; i++) {
      if (cartItemsPerOrder.containsKey(cartHistory[i].time)) {
        cartItemsPerOrder.update(cartHistory[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(cartHistory[i].time!, () => 1);
      }
    }
    List<int> cartItemsPerOrdertoList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrdertoList();
    var listCounter = 0;

    Widget timeWidget(int index) {
      var outPutDate = DateTime.now().toString();
      if (index < cartHistory.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(cartHistory[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outPutDate = outputFormat.format(inputDate);
      }

      return Text(outPutDate,
          style: GoogleFonts.domine(
            fontSize: Dimensions.font16,
          ));
    }

    return Scaffold(
        // backgroundColor: Colors.white,
        body: Column(
      children: [
        // Container(
        //   width: double.maxFinite,
        //   height:
        //       Dimensions.height45 + Dimensions.height45 + Dimensions.height10,
        //   padding:
        //       EdgeInsets.only(top: Dimensions.height20 + Dimensions.height10),
        //   decoration: const BoxDecoration(
        //     color: Colors.green,
        //     boxShadow: [
        //       BoxShadow(
        //           blurRadius: 10,
        //           color: Colors.black45,
        //           // blurStyle: BlurStyle.outer,
        //           offset: Offset(0, 5)),
        //     ],
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       Text(
        //         "Cart History",
        //         style: GoogleFonts.domine(
        //             fontSize: Dimensions.font26 - 1, color: Colors.white),
        //       ),
        //       SizedBox(
        //         width: Dimensions.width20,
        //       ),
        //       AppIcon(
        //         icon: Icons.shopping_cart,
        //         iconColor: Colors.green,
        //         backgroundColor: Colors.white,
        //         size: Dimensions.iconSize24 + 11,
        //         iconSize: Dimensions.iconSize24 + 1,
        //       )
        //     ],
        //   ),
        // ),
        itemsPerOrder.isNotEmpty
            ? Expanded(
                child: Container(
                margin: EdgeInsets.only(),
                // child: ListView.builder(
                //     itemCount: itemsPerOrder.isEmpty ? 1 : itemsPerOrder.length,
                //     itemBuilder: (context, index) {
                //       return Text("data" + index.toString());
                //     }),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      for (int i = 0; i < itemsPerOrder.length; i++)
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(listCounter),
                              SizedBox(
                                height: Dimensions.height10 - 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i],
                                        (index) {
                                      if (listCounter < cartHistory.length) {
                                        listCounter++;
                                      }
                                      return index <= 2
                                          ? Container(
                                              height: (Dimensions.height45 +
                                                      Dimensions.height45) -
                                                  10,
                                              margin: EdgeInsets.only(
                                                left: Dimensions.width10 + 2,
                                              ),
                                              width: (Dimensions.width30 +
                                                      Dimensions.width30) +
                                                  20,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius15 /
                                                              2),
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          cartHistory[
                                                                  listCounter -
                                                                      1]
                                                              .image!))),
                                            )
                                          : SizedBox();
                                    }),
                                  ),
                                  Container(
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("Total",
                                            style: GoogleFonts.domine(
                                                color: Colors.black,
                                                fontSize:
                                                    Dimensions.font16 - 2)),
                                        Text(
                                            itemsPerOrder[i] > 1
                                                ? "${itemsPerOrder[i]} items"
                                                : "${itemsPerOrder[i]} item",
                                            style: GoogleFonts.domine(
                                                color: Colors.black,
                                                fontSize:
                                                    Dimensions.font20 - 2)),
                                        GestureDetector(
                                          onTap: () {
                                            var orderTime =
                                                cartOrderTimeToList();
                                            Map<int, CartModel> previousOrders =
                                                {};
                                            for (var j = 0;
                                                j < cartHistory.length;
                                                j++) {
                                              if (cartHistory[j].time ==
                                                  orderTime[i]) {
                                                previousOrders.putIfAbsent(
                                                    cartHistory[j].id!,
                                                    () => CartModel.fromJson(
                                                        jsonDecode(jsonEncode(
                                                            cartHistory[j]))));
                                              }
                                            }
                                            Get.find<CartController>()
                                                .setItems = previousOrders;
                                            Get.find<CartController>()
                                                .addToCartList();
                                            Get.toNamed(RouteHelper.cartPage);
                                          },
                                          child: Container(
                                            height: Dimensions.height15 + 10,
                                            width: (Dimensions.width20 * 4) + 5,
                                            decoration: BoxDecoration(
                                                // color: Colors.green,
                                                // boxShadow: [
                                                //   BoxShadow(
                                                //       blurRadius: 10,
                                                //       color: Colors.black45,
                                                //       offset: Offset(0, 3))
                                                // ],
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.green),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius15 -
                                                            9)),
                                            child: Center(
                                                child: Text(
                                              itemsPerOrder[i] > 1
                                                  ? "View items"
                                                  : "View item",
                                              style: GoogleFonts.domine(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Dimensions.font16 - 2),
                                            )),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ))
            : NoDataPage(
                imagelink: "assets/images/transaction (1).png",
                imageText: "Cart History Empty",
              )
      ],
    ));
  }
}
