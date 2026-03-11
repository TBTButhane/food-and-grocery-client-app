// import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you/Controllers/payment_controller.dart';
import 'package:shop4you/models/order_model.dart';
import 'package:shop4you/routes/route_helper.dart';
import 'package:shop4you/widgets/appicon.dart';
import 'package:shop4you/widgets/big_text.dart';
import 'package:shop4you/widgets/dimentions.dart';
import 'package:shop4you/widgets/order_status.dart';

import '../Controllers/notification_controller.dart';

class OrderStatusScreen extends StatefulWidget {
  final OrderModel orderModel = Get.arguments;
  final String? boolValue;
  String? mToken = "";
  late bool isSuccess;

  OrderStatusScreen({Key? key, required this.boolValue}) : super(key: key);

  @override
  _OrderStatusScreenState createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.boolValue == 'true') {
      Get.find<PaymentController>()
          .saveOrders(widget.orderModel, widget.orderModel.userId);
      getAdminToken();

      widget.isSuccess = true;
    } else {
      widget.isSuccess = false;
    }
  }

  Future<void> getAdminToken() async {
    FirebaseFirestore fStore = FirebaseFirestore.instance;
    await fStore.collection('admin').doc('adminToken').get().then((token) {
      widget.mToken = token['token'];
      print(widget.mToken);
      Get.find<NotificationController>().sendNotification(
          title: "New order received: Order ID: ${widget.orderModel.id}",
          nbody: "${widget.orderModel.placeOrderDetails!.cart!.first.name}",
          token: widget.mToken);
    });
  }

  Widget placeOrder() {
    if (widget.isSuccess == true) {
      return success();
    } else {
      return cancel();
    }
  }

  Widget success() {
    return OrderStatus(
      orderModel: widget.orderModel,
      isSucess: widget.isSuccess,
      onPressed: () {
        Get.offNamed(RouteHelper.getIntialPage());
      },
    );
  }

  Widget cancel() {
    return OrderStatus(
      orderModel: widget.orderModel,
      isSucess: widget.isSuccess,
      onPressed: () {
        Get.offNamed(RouteHelper.getIntialPage());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: BigText(
            text: "Order Status",
            fontColor: Colors.white,
            fontSize: Dimensions.font20 + 5),
        leading: GestureDetector(
          onTap: () {
            Get.offNamed(RouteHelper.getIntialPage());
          },
          child: AppIcon(
              backgroundColor: Colors.green,
              icon: Icons.arrow_back_ios_new,
              iconSize: Dimensions.font20 + 5),
        ),
      ),
      body: placeOrder(),
    );
  }
}
