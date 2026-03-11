import 'dart:convert';

import 'package:shop4you/models/cart_model.dart';

PlaceOrderModel pLaceOrderModelFromJson(String str) =>
    PlaceOrderModel.fromJson(json.decode(str));

String toJson(PlaceOrderModel data) => json.encode(data.toJson());

class PlaceOrderModel {
  PlaceOrderModel({
    this.cart,
    this.orderAmount,
    this.orderNote,
    this.distance,
    this.address,
    this.longitude,
    this.latitude,
    this.contactPersonName,
    this.contactPersonNumber,
    this.contactPersonEmail,
    this.scheduleAt,
    this.orderType,
    this.paymentMethod,
  });

  List<CartModel>? cart;
  double? orderAmount;
  String? orderNote;
  double? distance;
  String? address;
  String? longitude;
  String? latitude;
  String? contactPersonName;
  String? contactPersonNumber;
  String? contactPersonEmail;
  String? scheduleAt;
  String? orderType;
  String? paymentMethod;

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      PlaceOrderModel(
        cart: List<CartModel>.from(
            json["cart"].map((x) => CartModel.fromJson(x))),
        orderAmount: json["order_amount"],
        orderNote: json["order_note"],
        distance: json["distance"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        contactPersonName: json["contact_person_name"],
        contactPersonNumber: json["contact_person_number"],
        contactPersonEmail: json["contact_person_email"],
        scheduleAt: json["schedule_at"],
        orderType: json["order_type"],
        paymentMethod: json["payment_method"],
      );

  Map<String, dynamic> toJson() => {
        "cart": List<dynamic>.from(cart!.map((x) => x.toJson())),
        "order_amount": orderAmount,
        "order_note": orderNote,
        "distance": distance,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "contact_person_name": contactPersonName,
        "contact_person_number": contactPersonNumber,
        "contact_person_email": contactPersonEmail,
        "schedule_at": scheduleAt,
        "order_type": orderType,
        "payment_method": paymentMethod,
      };
}

// class PlaceOrderModel {
//   // late String _id;
//   List<CartModel>? _cart;
//   late double _orderAmount;
//   late String _orderNote;
//   late double _distance;
//   late String _address;
//   late String _longitude;
//   late String _latitude;
//   late String _scheduleAt;
//   late String _contactPersonName;
//   late String _contactPersonNumber;
//   late String _contactPersonEmail;
//   late String _orderType;
//   late String _paymentMethod;
//   PlaceOrderModel({
//     // required String id,
//     required List<CartModel> cart,
//     required double orderAmount,
//     required String orderNote,
//     required double distance,
//     required String address,
//     required String longitude,
//     required String latitude,
//     required String scheduleAt,
//     required String contactPersonName,
//     required String contactPersonNumber,
//     required String contactPersonEmail,
//     required String orderType,
//     required String paymentMethod,
//   }) {
//     // _id = id;
//     _cart = cart;
//     _orderAmount = orderAmount;
//     _orderNote = orderNote;
//     _distance = distance;
//     _address = address;
//     _longitude = longitude;
//     _latitude = latitude;
//     _contactPersonName = contactPersonName;
//     _contactPersonNumber = contactPersonNumber;
//     _contactPersonEmail = contactPersonEmail;
//     _scheduleAt = scheduleAt;
//     _orderType = orderType;
//     _paymentMethod = paymentMethod;
//   }
//   // String? get id => _id;
//   List<CartModel> get cart => _cart!;
//   double get orderAmount => _orderAmount;
//   String get orderNote => _orderNote;
//   double get distance => _distance;
//   String get address => _address;
//   String get longitude => _longitude;
//   String get latitude => _latitude;
//   String get contactPersonName => _contactPersonName;
//   String get contactPersonNumber => _contactPersonNumber;
//   String get contactPersonEmail => _contactPersonEmail;
//   String get scheduleAt => _scheduleAt;
//   String get orderType => _orderType;
//   String get paymentMethod => _paymentMethod;

//   // Map<String, dynamic> toMap() => {
//   //       'cart': _cart != null ? _cart!.map((e) => e.toJson()) : null,
//   //       'order_Amount': _orderAmount,
//   //       'order_Note': _orderNote,
//   //       'distance': _distance,
//   //       'address': _address,
//   //       'longitude': _longitude,
//   //       'latitude': _latitude,
//   //       'contact_Person_Name': _contactPersonName,
//   //       'contact_Person_Number': _contactPersonNumber,
//   //       'schedule_At': _scheduleAt,
//   //       'order_type': _orderType,
//   //       'payment_method': _paymentMethod
//   //     };
//   Map<String, dynamic> toMap() {
//     final Map<String, dynamic> data = <String, dynamic>{};

//     if (_cart != null) {
//       data['cart'] = _cart!.map((e) => e.toJson()).toList();
//     }

//     data['order_amount'] = _orderAmount;
//     data['order_note'] = _orderNote;
//     data['distance'] = _distance;
//     data['address'] = _address;
//     data['longitude'] = _longitude;
//     data['latitude'] = _latitude;
//     data['contact_person_name'] = _contactPersonName;
//     data['contact_person_number'] = _contactPersonNumber;
//     data['contact_person_email'] = _contactPersonEmail;
//     data['schedule_at'] = _scheduleAt;
//     data['order_type'] = _orderType;
//     data['payment_method'] = _paymentMethod;

//     return data;
//   }

//   PlaceOrderModel.fromMap(Map<String, dynamic> map) {
//     if (map['cart'] != null) {
//       _cart = [];
//       map['cart'].forEach((v) {
//         _cart!.add(CartModel.fromJson(v));
//       });
//     }
//     _orderAmount = map['order_amount'];
//     _orderNote = map['order_note'];
//     _distance = map['distance'];
//     _address = map['address'];
//     _longitude = map['longitude'];
//     _latitude = map['latitude'];
//     _contactPersonName = map['contact_person_name'];
//     _contactPersonNumber = map['contact_Person_number'];
//     _contactPersonEmail = map['contact_Person_email'];
//     _scheduleAt = map['schedule_at'];
//     _orderType = map['order_type'];
//     _paymentMethod = map['payment_method'];
//   }

//   String toJson() => json.encode(toMap());

//   factory PlaceOrderModel.fromJson(String source) =>
//       PlaceOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }

