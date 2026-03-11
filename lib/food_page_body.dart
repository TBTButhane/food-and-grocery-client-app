// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:shop4you/Controllers/product_controller.dart';

import 'package:shop4you/widgets/dimentions.dart';

import 'package:shop4you/routes/route_helper.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  FoodPageBodyState createState() => FoodPageBodyState();
}

class FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.8);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //Slide section
        GetBuilder<PopularProductController>(builder: (controller) {
          return Container(
            height: (Dimensions.height45 +
                    Dimensions.height45 +
                    Dimensions.height30) *
                3,
            // color: Colors.red,
            child: PageView.builder(
                itemCount: controller.getproductsList.length,
                controller: pageController,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () => Get.toNamed(
                          RouteHelper.getRecommendedFood(index, "home")),
                      child: _buildPageItem(index, controller.getproductsList));
                }),
          );
        }),
        //Dots
        GetBuilder<PopularProductController>(
            builder: (controller) => DotsIndicator(
                  dotsCount: controller.getproductsList.isEmpty
                      ? 1
                      : controller.getproductsList.length,
                  position: _currentPageValue,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeColor: Colors.yellow.shade600,
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                )),
        //List of food and images
        SizedBox(height: 15),
        Container(
            margin: EdgeInsets.only(left: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Popular",
                    style:
                        GoogleFonts.roboto(color: Colors.black, fontSize: 20)),
                SizedBox(
                  width: 5,
                ),
                Container(
                  child: Text(".",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  child: Text("Food pairing",
                      style: GoogleFonts.roboto(
                          color: Colors.black38, fontSize: 12)),
                )
              ],
            )),
        GetBuilder<PopularProductController>(
            builder: (controller) {
              return controller.getPopularProduct.isEmpty? SizedBox(): ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.getPopularProduct.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(
                          RouteHelper.getPopularFood(index, "homePage"));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //picture section
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      controller.getPopularProduct[index].image)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          //Text Container
                          Expanded(
                            child: Container(
                                height: 100,
                                margin: EdgeInsets.only(
                                  bottom: 10,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5.0,
                                    top: 5,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          controller
                                              .getPopularProduct[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w400,
                                              fontSize: Dimensions.font20)),
                                      SizedBox(height: 10),
                                      Text(
                                          controller
                                              .getPopularProduct[index].desc,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w400,
                                              fontSize: Dimensions.font16)),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(Icons.circle,
                                              color: Colors.yellow.shade600,
                                              size: Dimensions.font16),
                                          SizedBox(width: 3),
                                          Text("Normal",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black45,
                                                  fontSize: Dimensions.font16)),
                                          SizedBox(width: 3),
                                          // Icon(Icons.location_pin,
                                          //     size: Dimensions.font16,
                                          //     color: Colors.yellow.shade600),
                                          // SizedBox(width: 3),
                                          // Text("1.7 km",
                                          //     style: GoogleFonts.roboto(
                                          //         color: Colors.black45,
                                          //         fontSize: Dimensions.font16)),
                                          SizedBox(width: 3),
                                          Icon(Icons.timer,
                                              size: Dimensions.font16,
                                              color: Colors.yellow.shade600),
                                          SizedBox(width: 3),
                                          Text("32min",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black45,
                                                  fontSize: Dimensions.font16)),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                });
            }),
      ],
    );
  }

  Widget _buildPageItem(
    int index,
    getproductsList,
  ) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Stack(
            children: [
              Container(
                height: (Dimensions.height45 + Dimensions.height45) * 3,
                margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10, top: Dimensions.height10-5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          getproductsList[index].image.toString())),
                  borderRadius: BorderRadius.circular(30),
                ),
                // child: Center(child: Text(index.toString())),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: (Dimensions.height45 +
                            Dimensions.height30 +
                            Dimensions.height30) +
                        Dimensions.height10,
                    margin: EdgeInsets.only(
                        left: Dimensions.width15,
                        right: Dimensions.width15,
                        bottom: Dimensions.height30 + Dimensions.height20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45,
                              blurRadius: 5.0,
                              offset: Offset(0, 5)),
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 0,
                              offset: Offset(-5, 0)),
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 5.0,
                              offset: Offset(5, 0))
                        ],
                        color: Colors.white),
                    child: Center(
                      child: Container(
                          padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(getproductsList[index].name,
                                    style: GoogleFonts.roboto(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w400,
                                        fontSize: Dimensions.font20)),
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Wrap(
                                    children: List.generate(
                                        5,
                                        (index) => Icon(Icons.star,
                                            size: Dimensions.font16,
                                            color: Colors.yellow.shade600)),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("4.5",
                                      style: GoogleFonts.roboto(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w400,
                                          fontSize: Dimensions.font16)),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  // Text("1287",
                                  //     style: GoogleFonts.roboto(
                                  //         color: Colors.black45,
                                  //         fontWeight: FontWeight.w400,
                                  //         fontSize: Dimensions.font16)),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  // Text("Comments",
                                  //     style: GoogleFonts.roboto(
                                  //         color: Colors.black45,
                                  //         fontWeight: FontWeight.w400,
                                  //         fontSize: Dimensions.font16)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.circle,
                                      color: Colors.yellow.shade600,
                                      size: Dimensions.font16),
                                  SizedBox(width: 3),
                                  Text("Normal",
                                      style: GoogleFonts.roboto(
                                          color: Colors.black45,
                                          fontSize: Dimensions.font16)),
                                  SizedBox(width: 10),
                                  // Icon(Icons.location_pin,
                                  //     size: Dimensions.font16,
                                  //     color: Colors.yellow.shade600),
                                  // SizedBox(width: 3),
                                  // Text("1.7 km",
                                  //     style: GoogleFonts.roboto(
                                  //         color: Colors.black45,
                                  //         fontSize: Dimensions.font16)),
                                  SizedBox(width: 10),
                                  Icon(Icons.timer,
                                      size: Dimensions.font16,
                                      color: Colors.yellow.shade600),
                                  SizedBox(width: 3),
                                  Text("32min",
                                      style: GoogleFonts.roboto(
                                          color: Colors.black45,
                                          fontSize: Dimensions.font16)),
                                  SizedBox(width: 10)
                                ],
                              )
                            ],
                          )),
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}
