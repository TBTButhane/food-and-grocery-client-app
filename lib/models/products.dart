// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

import 'package:shop4you/models/restaurant_model.dart';

class ProductModel {
  int? id;
  String? name;
  String? desc;
  String? image;
  int? price;
  bool? popular;
  bool? hasAddon;
  List<AddonModel>? addons;
  RestaurantsModel? restaurantsModel;

  ProductModel({
    this.id,
    this.name,
    this.desc,
    this.image,
    this.price,
    this.popular,
    this.hasAddon,
    this.addons,
    this.restaurantsModel,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? "";
    name = json["name"] ?? "";
    desc = json["desc"] ?? "";
    image = json["image"] ?? "";
    price = json["price"] ?? "";
    popular = json["popular"] ?? false;
    hasAddon = json["hasAddon"] ?? false;
    addons = json["addons"] != null
        ? List<AddonModel>.from(
            json["addons"].map((x) => AddonModel.fromJson(x)))
        : [];
    restaurantsModel = RestaurantsModel.fromJson(json["restaurant"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "image": image,
        "price": price,
        "popular": popular,
        "hasAddon": hasAddon,
        "adons": List<dynamic>.from(addons!.map((x) => x.toJson())),
        "restaurant": restaurantsModel!.toJson(),
      };
}

class AddonModel {
  String? id;
  String? name;
  String? image;
  double? price;

  AddonModel({
    this.id,
    this.name,
    this.image,
    this.price,
  });

  AddonModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? "";
    name = json["name"] ?? "";
    image = json["image"] ?? "";
    id = json["price"] ?? "";
  }
  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "image": image, "price": price};
}
