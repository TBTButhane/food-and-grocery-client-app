// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop4you/models/products.dart';
// import 'dart:convert';
import 'package:shop4you/models/restaurant_model.dart';
import 'package:shop4you/util/apiClient.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;
  FirebaseFirestore _firebaseDb = FirebaseFirestore.instance;

  ProductRepo({required this.apiClient});
  Future<List<ProductModel>> getProductsList(
      DocumentSnapshot? proLastDoc) async {
    if (proLastDoc == null) {
      return await _firebaseDb
          .collection("products")
          .orderBy("name")
          .get()
          .then((value) {
        proLastDoc = value.docs.last;
        // var string = value.docs.map((e) => jsonEncode(e.data()));
        // print(string);
        // return [];
        return value.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      });
    } else {
      return await _firebaseDb
          .collection("products")
          .orderBy("name")
          .get()
          .then((value) {
        proLastDoc = value.docs.last;
        // var string = value.docs.map((e) => jsonEncode(e.data()));
        // print(string);
        // return [];
        return value.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      });
    }
  }

  Future<List<RestaurantsModel>> getRestaurantList(
      DocumentSnapshot? lastDoc) async {
    if (lastDoc == null) {
      return await _firebaseDb
          .collection("restaurants")
          .orderBy("name")
          .get()
          .then((value) {
        lastDoc = value.docs.last;
        return value.docs
            .map((e) => RestaurantsModel.fromJson(e.data()))
            .toList();
      });
    } else {
      return await _firebaseDb
          .collection("restaurants")
          .orderBy("name")
          .get()
          .then((value) {
        lastDoc = value.docs.last;
        return value.docs
            .map((e) => RestaurantsModel.fromJson(e.data()))
            .toList();
      });
    }
  }
}
