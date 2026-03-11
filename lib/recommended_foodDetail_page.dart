// ignore: duplicate_ignore
// ignore: file_names

// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop4you/Controllers/cart_controller.dart';

import 'package:shop4you/Controllers/product_controller.dart';
import 'package:shop4you/routes/route_helper.dart';
import 'package:shop4you/widgets/appicon.dart';
import 'package:shop4you/widgets/food_details_expanded_text.dart';

// ignore: camel_case_types
class Recommended_FoodDetails_Page extends StatefulWidget {
  final int pageId;
  final String page;
  const Recommended_FoodDetails_Page(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  State<Recommended_FoodDetails_Page> createState() =>
      _recommended_FoodDetails_PageState();
}

class _recommended_FoodDetails_PageState
    extends State<Recommended_FoodDetails_Page> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    var product =
        Get.find<PopularProductController>().getproductsList[widget.pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      // ignore: prefer_const_constructors
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            toolbarHeight: 70,
            title: Row(
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
                    icon: Icons.clear,
                    iconColor: Colors.white,
                    backgroundColor: Colors.green,
                    size: 35,
                    iconSize: 25,
                  ),
                ),
                GetBuilder<PopularProductController>(builder: ((product) {
                  return GestureDetector(
                    onTap: () {
                      if (product.totalItems >= 1) {
                        Get.toNamed(RouteHelper.getCartPagge("cart"));
                      }
                    },
                    child: Stack(children: [
                      AppIcon(
                        icon: Icons.shopping_cart_outlined,
                        size: 35,
                        iconSize: 25,
                        iconColor: Colors.white,
                        backgroundColor: Colors.green,
                      ),
                      product.totalItems >= 1
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: 21,
                                iconColor: Colors.transparent,
                                backgroundColor: Colors.white,
                              ),
                            )
                          : SizedBox(),
                      product.totalItems >= 1
                          ? Positioned(
                              right: 6,
                              top: 3,
                              child: Center(
                                child: Text(
                                  product.totalItems.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green),
                                ),
                              ),
                            )
                          : SizedBox()
                    ]),
                  );
                }))
              ],
            ),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(product.name,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ))),
            pinned: true,
            expandedHeight: 300,
            // leading: Container(),s
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.image,
                fit: BoxFit.fill,
                width: double.maxFinite,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: FoodExpandedText(text: product.desc),
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                          icon: Icons.remove,
                          backgroundColor: Colors.blue,
                          iconSize: 25,
                          size: 35),
                    ),
                    Text(
                      "R ${product.price} x ${controller.inCartItems}",
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                        icon: Icons.add,
                        backgroundColor: Colors.blue,
                        iconSize: 25,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 80,
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
                            top: 10, bottom: 10, left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child:
                            Icon(Icons.favorite, color: Colors.red, size: 25),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.addItem(product);
                        },
                        child: Container(
                          // height: 50,
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, left: 15, right: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.shade400),
                          child: Text("Add to cart",
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15)),
                        ),
                      )
                    ],
                  ))
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
