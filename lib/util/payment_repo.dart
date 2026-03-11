// import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop4you/models/order_model.dart';
import 'package:shop4you/util/apiClient.dart';

class PaymentRepo {
  final ApiClient apiClient;
  final FirebaseFirestore _fStore = FirebaseFirestore.instance;

  PaymentRepo({required this.apiClient});

  Future<List<OrderModel>> userOrderList(String userId) async {
    List<OrderModel> orders = await _fStore
        .collection('users')
        .doc(userId)
        .collection('orders').orderBy("createdAt")
        .get()
        .then((value) {
      return value.docs.map((e) => OrderModel.fromJson(e.data())).toList();
    });

    return orders;
  }

  Future<List<OrderModel>> ordersList() async {
    List<OrderModel> orders = await _fStore.collection('orders').get().then(
        (value) =>
            value.docs.map((e) => OrderModel.fromJson(e.data())).toList());

    return orders;
  }

  Future<void> saveOrders(OrderModel orderModel, String userId) async {
    await _fStore
        .collection('orders')
        .doc('order ${orderModel.id}')
        .set(orderModel.toJson());
    await clientOrders(orderModel, userId);
  }

  Future<void> clientOrders(OrderModel orderModel, String userId) async {
    await _fStore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc('order ${orderModel.id}')
        .set(orderModel.toJson());
  }
}
