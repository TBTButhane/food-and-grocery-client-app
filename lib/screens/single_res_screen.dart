// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop4you/Controllers/auth_controller.dart';
import 'package:shop4you/Controllers/cart_controller.dart';
import 'package:shop4you/Controllers/product_controller.dart';
import 'package:shop4you/models/restaurant_model.dart';

import 'package:shop4you/widgets/big_text.dart';
import 'package:shop4you/widgets/dimentions.dart';

class SingleResScreen extends StatefulWidget {

  const SingleResScreen(
      {Key? key,  })
      : super(key: key);

  @override
  State<SingleResScreen> createState() => _SingleResScreenState();
}

class _SingleResScreenState extends State<SingleResScreen> {
  final dynamic args = Get.arguments;

  RestaurantsModel? restaurant;

  List<dynamic>? productList;

  @override
  void initState() {
  
    restaurant  = args[0]['restaurant'];
    productList = args[1]['productList'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        // title: Text("${product.restaurant!.name}"),
        title: BigText(
          text: "${restaurant!.name}",
          isBold: true,
          fontSize: 20,
          fontColor: Colors.white,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<PopularProductController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimensions.height45 * 5,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(restaurant!.logo.toString()))),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Text("Food Menu",
                  style: GoogleFonts.domine(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: Dimensions.height10,
              ),
              Expanded(
                  child: productList!.isEmpty
                      ? SizedBox()
                      : ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productList!.length,
                          itemBuilder: (_, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: productList!.length == 1
                                      ? Border()
                                      : Border(
                                          bottom: BorderSide(
                                              color: Colors.black, width: 1))),
                              margin: EdgeInsets.only(
                                  left: 5, right: 10, bottom: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //picture section
                                  Container(
                                    width: (Dimensions.width30 +
                                            Dimensions.width20) *
                                        2,
                                    height: (Dimensions.height30 +
                                            Dimensions.height20) *
                                        2,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(productList![index]
                                              .image
                                              .toString())),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  //Text Container
                                  Expanded(
                                    child: Container(
                                        height: (Dimensions.height30 +
                                                Dimensions.height20) *
                                            2,
                                        margin: EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5.0,
                                            top: 5,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  productList![index]
                                                      .name
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          Dimensions.font20)),
                                              SizedBox(height: 5),
                                              Text(
                                                  "R ${productList![index].price}",
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          Dimensions.font20)),
                                            ],
                                          ),
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () async{
                                     
                                      
                                      if (Get.find<AuthController>()
                                          .isLoggedIn()) {
                                             Get.find<PopularProductController>()
        .initProduct(productList![index], Get.find<CartController>());
                                        controller.setQuantity(true);
                                        controller.addItem(productList![index]);
                                        controller.setQuantityZero;
                                        Get.snackbar(
                                            "${productList![index].name}",
                                            "Product was successfully added to cart",
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white,
                                            icon: Icon(
                                              Icons.done,
                                              size: 25,
                                              color: Colors.white,
                                            ),
                                            margin: EdgeInsets.only(
                                              top: Dimensions.height10 * 3,
                                              left: Dimensions.width15,
                                              right: Dimensions.width15,
                                            ),
                                            animationDuration:
                                                Duration(seconds: 5));
                                      } else {
                                        Get.snackbar("Sign-in first",
                                            "Please log into your account or register a new one",
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                            icon: Icon(
                                              Icons.cancel_outlined,
                                              size: 25,
                                              color: Colors.white,
                                            ),
                                            margin: EdgeInsets.only(
                                              top: Dimensions.height10 * 3,
                                              left: Dimensions.width15,
                                              right: Dimensions.width15,
                                            ),
                                            animationDuration:
                                                Duration(seconds: 5));
                                      }

                                      // Get.toNamed(RouteHelper.getPopularFood(
                                      //     index, "SingleResPage"));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                          top: Dimensions.height10 +
                                              Dimensions.height20,
                                        ),
                                        padding: EdgeInsets.all(
                                            Dimensions.height10 - 2),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 10,
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 1,
                                                  offset: Offset(0, 5))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: BigText(
                                          fontSize: 16,
                                          fontColor: Colors.white,
                                          text: "Add to cart",
                                        )),
                                  ),
                                ],
                              ),
                            );
                          }))
            ],
          ),
        );
      }),
    );
  }
}
