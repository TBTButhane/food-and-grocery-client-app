// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop4you/Controllers/product_controller.dart';
import 'package:shop4you/food_page_body.dart';
import 'package:shop4you/models/restaurant_model.dart';
import 'package:shop4you/routes/route_helper.dart';
import 'package:shop4you/util/popular_repo.dart';
import 'package:shop4you/widgets/big_text.dart';
import 'package:shop4you/widgets/custom_loader.dart';
import 'package:shop4you/widgets/dimentions.dart';
import 'Controllers/auth_controller.dart';

class FoodHomePage extends StatefulWidget {
  const FoodHomePage({Key? key}) : super(key: key);

  @override
  FoodHomePageState createState() => FoodHomePageState();
}

class FoodHomePageState extends State<FoodHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    Get.put(ProductRepo(apiClient: Get.find()));
    Get.put(PopularProductController(popularProductRepo: Get.find()));
    // Get.find<PopularProductController>().getProductListMethod();
    Get.find<PopularProductController>().getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          storeAppBar(),
          restaurants(),
          SizedBox(
            height: 10,
          ),
          Expanded(child: SingleChildScrollView(child: FoodPageBody())),
        ],
      ),
    );
  }

  restaurants() {
    return GetBuilder<PopularProductController>(
      builder: (controller) {
        List<RestaurantsModel> sortRestaurants = controller.resList;
        var cutDuplicates = <dynamic>{};
        List<RestaurantsModel> sortDuplicates = [];
        sortDuplicates = sortRestaurants
            .where((element) => cutDuplicates.add(element.name))
            .toList();
        return controller.resList.isEmpty
            ? SizedBox()
            : controller.resList.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: Dimensions.height30+Dimensions.height45,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: sortDuplicates.length,
                              // itemCount: controller.getproductsList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width:
                                      Dimensions.height45 + Dimensions.height20,
                                  height:
                                      Dimensions.height45 + Dimensions.height30,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              sortDuplicates[index].logo!))),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(width: 10);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () => Get.toNamed(
                                RouteHelper.getViewAllRestuarants()),
                            child: BigText(text:"View All", fontColor: Colors.green, isBold: true, fontSize: Dimensions.font20-2),
                          ),
                        )
                      ],
                    ),
                  )
                : Center(child: CustomLoader());
      },
    );
  }

  storeAppBar() {
    return GetBuilder<AuthController>(builder: (authController) {
      bool loggedIn = authController.isLoggedIn();
      return !loggedIn
          ? Container(
              margin: EdgeInsets.only(top: 70, bottom: 15),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Text("Welcome",
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: Dimensions.font26)),
                  ]),

                  // Container(
                  //     height: 45,
                  //     width: 45,
                  //     decoration: BoxDecoration(
                  //         color: Colors.blueGrey,
                  //         borderRadius: BorderRadius.circular(15)),
                  //     child: Center(child: Icon(Icons.search, color: Colors.white)))
                ],
              ),
            )
          : Container(
              margin: EdgeInsets.only(top: 50, bottom: 15),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello",
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.font26)),
                        Text(
                            authController.storedUserDetails?.name != null
                                ? authController
                                    .storedUserDetails!.name.capitalize!
                                : "user",
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: Dimensions.font16 + 3))
                      ]),
                  // Container(
                  //     height: 45,
                  //     width: 45,
                  //     decoration: BoxDecoration(
                  //         color: Colors.blueGrey,
                  //         borderRadius: BorderRadius.circular(15)),
                  //     child: Center(child: Icon(Icons.search, color: Colors.white)))
                ],
              ),
            );
    });
  }
}
