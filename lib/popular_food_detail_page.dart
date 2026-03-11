// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop4you/Controllers/cart_controller.dart';
import 'package:shop4you/Controllers/product_controller.dart';

import 'package:shop4you/widgets/dimentions.dart';
import 'package:shop4you/routes/route_helper.dart';
import 'package:shop4you/widgets/appicon.dart';
import 'package:shop4you/widgets/app_icon_text.dart';
import 'package:shop4you/widgets/food_details_expanded_text.dart';

class PopularFood extends StatefulWidget {
  final int pageId;
  final String page;

  const PopularFood({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);

  @override
  State<PopularFood> createState() => _PopularFoodState();
}

class _PopularFoodState extends State<PopularFood> {
  @override
  Widget build(BuildContext context) {
    //TODO: Enable this below and remve the productist[0] to make it dynamic
    var product =
        Get.find<PopularProductController>().getproductsList[widget.pageId];

    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(product.image))),
                )),
            Positioned(
                top: Dimensions.height45,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.page == "cartpage") {
                          Get.toNamed(RouteHelper.getCartPagge("cart"));
                        } else {
                          Get.toNamed(RouteHelper.getIntialPage());
                        }
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back_ios_rounded,
                        size: 32,
                        iconSize: 25,
                        iconColor: Colors.white,
                        backgroundColor: Colors.black87,
                      ),
                    ),
                    GetBuilder<PopularProductController>(builder: ((product) {
                      return GestureDetector(
                        onTap: () {
                          if (product.totalItems >= 1) {
                            Get.toNamed(RouteHelper.getCartPagge("cart"));
                          }
                        },
                        // ignore: prefer_const_literals_to_create_immutables
                        child: Stack(children: [
                          AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            size: 32,
                            iconSize: 25,
                            iconColor: Colors.white,
                            backgroundColor: Colors.black87,
                          ),
                          product.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 21,
                                    iconColor: Colors.transparent,
                                    backgroundColor: Colors.green,
                                  ),
                                )
                              : SizedBox(),
                          product.totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 3,
                                  child: Text(
                                    product.totalItems.toString(),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                )
                              : SizedBox()
                        ]),
                      );
                    }))
                  ],
                )),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 250,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name,
                          style: GoogleFonts.roboto(
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                              fontSize: 20)),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                                5,
                                (index) => Icon(Icons.star,
                                    size: 12, color: Colors.yellow.shade600)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("4.5",
                              style: GoogleFonts.roboto(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12)),
                          SizedBox(
                            width: 10,
                          ),
                          Text("1287",
                              style: GoogleFonts.roboto(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12)),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Comments",
                              style: GoogleFonts.roboto(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppIconAndText(
                            icon: Icons.circle,
                            text: "Normal",
                            iconColr: Colors.yellow.shade600,
                            fontColr: Colors.black45,
                            fontSize: 12,
                            iconSize: 15,
                          ),
                          AppIconAndText(
                            icon: Icons.location_pin,
                            text: "1.7 km",
                            iconColr: Colors.yellow.shade600,
                            fontColr: Colors.black45,
                            fontSize: 12,
                            iconSize: 15,
                          ),
                          AppIconAndText(
                            icon: Icons.timer,
                            text: "32min",
                            iconColr: Colors.yellow.shade600,
                            fontColr: Colors.black45,
                            fontSize: 12,
                            iconSize: 15,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Introduce",
                          style: GoogleFonts.roboto(
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                              fontSize: 18)),
                      SizedBox(height: 2),
                      Expanded(
                          child: SingleChildScrollView(
                        child: FoodExpandedText(
                          text: product.desc,
                        ),
                      )),
                      SizedBox(height: 15),
                    ],
                  ),
                )),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProduct) {
            return Container(
                height: Dimensions.height45 + Dimensions.height45,
                padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // height: 50,
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              popularProduct.setQuantity(false);
                            },
                            child: AppIcon(
                              icon: Icons.remove,
                              iconSize: 25,
                              size: 45,
                            ),
                          ),
                          SizedBox(width: 3),
                          Text("${popularProduct.inCartItems}",
                              style: GoogleFonts.roboto(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20)),
                          SizedBox(width: 3),
                          GestureDetector(
                            onTap: () {
                              popularProduct.setQuantity(true);
                            },
                            child: AppIcon(
                              icon: Icons.add,
                              iconSize: 25,
                              size: 45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //TODO: make the bellow function work with the product eh\g fix the above product variable "product"
                        popularProduct.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.shade400),
                        child: Text("R${product.price} | Add to cart",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15)),
                      ),
                    )
                  ],
                ));
          },
        ));
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
