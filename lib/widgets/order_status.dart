import 'package:flutter/material.dart';
import 'package:shop4you/models/order_model.dart';
import 'package:shop4you/widgets/big_text.dart';
import 'package:shop4you/widgets/custom_button.dart';
import 'package:shop4you/widgets/dimentions.dart';

class OrderStatus extends StatelessWidget {
  final OrderModel? orderModel;
  final Function()? onPressed;
  final bool isSucess;
  const OrderStatus(
      {Key? key, this.orderModel, this.onPressed, required this.isSucess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSucess == true
        ? Container(
            height: Dimensions.screenHeight,
            width: Dimensions.screenWidth,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              BigText(
                text: "CONGRATULATIONS",
                fontSize: Dimensions.font26 + 10,
                isBold: true,
                fontColor: Colors.green,
              ),
              SizedBox(
                height: Dimensions.height45 * 2,
              ),
              Container(
                height: Dimensions.height45 * 3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/shop4you.png'))),
              ),
              SizedBox(
                height: Dimensions.height45 * 2,
              ),
              BigText(
                text: "Your Order: ${orderModel!.id} was Successfull",
                fontSize: Dimensions.font20 + 5,
              ),
              SizedBox(
                height: Dimensions.height45 * 3,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.width15,
                  right: Dimensions.width15,
                ),
                child: CustomButton(
                  buttonText: "Back to Home",
                  onPressed: () {
                    onPressed!();
                  },
                  transparent: false,
                  fontSize: Dimensions.font20 + 5,
                  width: Dimensions.screenWidth,
                  height: Dimensions.height45 + Dimensions.height20,
                ),
              )
            ]),
          )
        : Container(
            height: Dimensions.screenHeight,
            width: Dimensions.screenWidth,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: Dimensions.height45 * 3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/shop4you.png'))),
              ),
              SizedBox(
                height: Dimensions.height45 * 2,
              ),
              BigText(
                text: "UNFORTUNATELY",
                fontSize: Dimensions.font26 + 10,
                isBold: true,
                fontColor: Colors.green,
              ),
              SizedBox(
                height: Dimensions.height45 * 2,
              ),
              BigText(
                text: "Your Order was Unsuccessfull",
                fontSize: Dimensions.font20 + 5,
              ),
              SizedBox(
                height: Dimensions.height45 * 3,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.width15,
                  right: Dimensions.width15,
                ),
                child: CustomButton(
                  buttonText: "Back to Home",
                  onPressed: () {
                    onPressed!();
                  },
                  transparent: false,
                  fontSize: Dimensions.font20 + 5,
                  width: Dimensions.screenWidth,
                  height: Dimensions.height45 + Dimensions.height20,
                ),
              )
            ]),
          );
  }
}
