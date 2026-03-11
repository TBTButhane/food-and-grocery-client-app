// import 'dart:convert';

import 'package:shop4you/models/address_model.dart';
import 'package:shop4you/models/place_order_model.dart';

class OrderModel {
  late String id;
  late String userId;
  double? orderAmount;
  String? orderStatus;
  String? paymentStatus;
  double? totalTaxamount;
  String? orderNote;
  String? createdAt;
  String? updatedAt;
  double? deliveryCharge;
  String? scheduledAt;
  String? otp;
  String? pending;
  String? accepted;
  String? confirmed;
  String? processing;
  String? handover;
  String? pickedUp;
  String? delivered;
  String? canceled;
  String? refundRequested;
  String? refunded;
  int? scheduled;
  String? failed;
  int? detailsCount;

  AddressModel? deliveryAddress;
  PlaceOrderModel? placeOrderDetails;
  OrderModel(
      {required this.id,
      required this.userId,
      this.orderAmount,
      this.orderStatus,
      this.paymentStatus,
      this.totalTaxamount,
      this.orderNote,
      this.createdAt,
      this.updatedAt,
      this.deliveryCharge,
      this.scheduledAt,
      this.otp,
      this.pending = 'pending',
      this.accepted,
      this.confirmed,
      this.processing,
      this.handover,
      this.pickedUp,
      this.delivered,
      this.canceled,
      this.refundRequested,
      this.refunded,
      this.scheduled,
      this.failed,
      this.detailsCount,
      this.deliveryAddress,
      this.placeOrderDetails});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'orderAmount': orderAmount,
      'orderStatus': orderStatus,
      'paymentStatus': paymentStatus,
      'totalTaxamount': totalTaxamount,
      'orderNote': orderNote,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deliveryCharge': deliveryCharge,
      'scheduledAt': scheduledAt,
      'otp': otp,
      'pending': pending,
      'accepted': accepted,
      'confirmed': confirmed,
      'processing': processing,
      'handover': handover,
      'pickedUp': pickedUp,
      'delivered': delivered,
      'canceled': canceled,
      'refundRequested': refundRequested,
      'refunded': refunded,
      'scheduled': scheduled,
      'failed': failed,
      'detailsCount': detailsCount,
      'deliveryAddress': deliveryAddress!.toJson(),
      'orderDetails': placeOrderDetails!.toJson()
    };
  }

  OrderModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    userId = map['userId'];
    orderAmount =
        map['orderAmount'] != null ? map['orderAmount'] as double : null;
    orderStatus =
        map['orderStatus'] != null ? map['orderStatus'] as String : "pending";
    paymentStatus =
        map['paymentStatus'] != null ? map['paymentStatus'] as String : null;
    totalTaxamount =
        map['totalTaxamount'] != null ? map['totalTaxamount'] as double : null;
    orderNote = map['orderNote'] != null ? map['orderNote'] as String : null;
    createdAt = map['createdAt'] != null ? map['createdAt'] as String : null;
    updatedAt = map['updatedAt'] != null ? map['updatedAt'] as String : null;
    deliveryCharge =
        map['deliveryCharge'] != null ? map['deliveryCharge'] as double : null;
    scheduledAt =
        map['scheduledAt'] != null ? map['scheduledAt'] as String : null;
    otp = map['otp'] != null ? map['otp'] as String : null;
    pending = map['pending'] != null ? map['pending'] as String : null;
    accepted = map['accepted'] != null ? map['accepted'] as String : null;
    confirmed = map['confirmed'] != null ? map['confirmed'] as String : null;
    processing = map['processing'] != null ? map['processing'] as String : null;
    handover = map['handover'] != null ? map['handover'] as String : null;
    pickedUp = map['pickedUp'] != null ? map['pickedUp'] as String : null;
    delivered = map['delivered'] != null ? map['delivered'] as String : null;
    canceled = map['canceled'] != null ? map['canceled'] as String : null;
    refundRequested = map['refundRequested'] != null
        ? map['refundRequested'] as String
        : null;
    refunded = map['refunded'] != null ? map['refunded'] as String : null;
    scheduled = map['scheduled'] != null ? map['scheduled'] as int : null;
    failed = map['failed'] != null ? map['failed'] as String : null;
    detailsCount =
        map['detailsCount'] != null ? map['detailsCount'] as int : null;
    deliveryAddress = map['delivery_Address'] != null
        ? AddressModel.fromJson(map['delivery_Address'] as Map<String, dynamic>)
        : null;
    placeOrderDetails = map['orderDetails'] != null
        ? PlaceOrderModel.fromJson(map['orderDetails'])
        : null;
  }
}
