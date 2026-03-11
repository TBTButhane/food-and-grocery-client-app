// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:shop4you/routes/route_helper.dart';
// import 'package:shop4you/screens/single_res_screen.dart';
import 'package:shop4you/Controllers/product_controller.dart';
import 'package:shop4you/models/restaurant_model.dart';
import 'package:shop4you/widgets/big_text.dart';
import 'package:shop4you/widgets/dimentions.dart';

class AllRestaurents extends StatelessWidget {
  const AllRestaurents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Restaurents",
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: restaurantCard(),
    );
  }
}

Widget resCard({String? img, String? resName}) {
  return Card(
    elevation: 0.5,
    shadowColor: Colors.green,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: Dimensions.height45 + Dimensions.height45,
          width: (Dimensions.width30 * 2) + 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(img!))),
        ),
        Expanded(
          child: BigText(
            text: resName!,
            isBold: true,
            fontSize: 20,
          ),
        ),
        Icon(Icons.arrow_forward_ios_rounded)
      ],
    ),
  );
}

Widget restaurantCard() {
  return GetBuilder<PopularProductController>(builder: (controller) {
    List<RestaurantsModel> sortRestaurants = controller.resList;
    var cutDuplicates = <dynamic>{};
    List<RestaurantsModel> sortDuplicates = [];
    sortDuplicates = sortRestaurants
        .where((element) => cutDuplicates.add(element.name))
        .toList();

    return ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                List<dynamic> uniqueList = controller.getproductsList
                    .where((element) =>
                        element.restaurantsModel.name ==
                        sortDuplicates[index].name)
                    .toList();

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => SingleResScreen(
                //               restaurant: sortDuplicates[index],
                //               productList: uniqueList,
                //             )));
                Get.toNamed(
                  arguments: [{"restaurant": sortDuplicates[index]},{"productList": uniqueList} ],
                  RouteHelper.getSingleResScreen());
              },
              child: resCard(
                  img: sortDuplicates[index].logo,
                  resName: sortDuplicates[index].name));
        },
        itemCount: sortDuplicates.length);
  });
}
