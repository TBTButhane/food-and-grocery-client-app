import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you/Controllers/payment_controller.dart';
import 'package:shop4you/widgets/big_text.dart';
import 'package:shop4you/widgets/dimentions.dart';

class DeliveryOptionsButtons extends StatelessWidget {
  String value;
  String title;
  double amount;
  bool isFree;
  DeliveryOptionsButtons({
    Key? key,
    required this.value,
    required this.title,
    required this.amount,
    required this.isFree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(builder: (paymentController) {
      return Row(
        children: [
          Radio(
              value: value,
              groupValue: paymentController.orderType,
              activeColor: Colors.green,
              onChanged: (String? value) {
                paymentController.setDeliveryType(value!);
              }),
          SizedBox(
            width: Dimensions.width10 / 2,
          ),
          BigText(
            text: title,
            fontSize: Dimensions.font20,
          ),
          SizedBox(
            width: Dimensions.width10 / 2,
          ),
          BigText(
            text: value == 'take away' || isFree ? "(Free)" : "(R$amount)",
            fontSize: Dimensions.font20,
          ),
        ],
      );
    });
  }
}
