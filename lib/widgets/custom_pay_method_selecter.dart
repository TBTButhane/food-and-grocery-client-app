// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you/Controllers/payment_controller.dart';

import 'package:shop4you/widgets/big_text.dart';
import 'package:shop4you/widgets/dimentions.dart';

class CustomPayMethodSelecter extends StatelessWidget {
  String paymentTitle;
  IconData leadingIcon;
  IconData trallingIcon;
  String subtitle;
  int index;
  CustomPayMethodSelecter({
    Key? key,
    required this.paymentTitle,
    required this.leadingIcon,
    required this.trallingIcon,
    required this.subtitle,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(builder: (paymentController) {
      bool _selectedIndex = paymentController.paymentIndex == index;
      return InkWell(
        onTap: () => paymentController.setPaymentIndex(index),
        // onTap: () => print(index),
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
          height: Dimensions.screenHeight * 0.1,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              border: Border.all(width: 1, color: Colors.green)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(leadingIcon,
                  color: _selectedIndex
                      ? Colors.white
                      : Theme.of(context).disabledColor,
                  size: Dimensions.iconSize24 + 26),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(
                      text: paymentTitle,
                      fontColor: _selectedIndex
                          ? Colors.white
                          : Theme.of(context).disabledColor,
                      isBold: true,
                      fontSize: Dimensions.font20,
                    ),
                    BigText(
                      text: subtitle,
                      fontColor: _selectedIndex
                          ? Colors.white
                          : Theme.of(context).disabledColor,
                      isBold: false,
                      fontSize: Dimensions.font26 - 8,
                    ),
                  ],
                ),
              ),
              _selectedIndex
                  ? Icon(
                    trallingIcon,
                    color: Colors.white,
                    size: Dimensions.iconSize24 + 26,
                  )
                  : SizedBox(),
            ],
          ),
        ),
      );
    });
  }
}
