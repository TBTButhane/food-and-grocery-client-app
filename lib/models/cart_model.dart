import 'package:shop4you/models/products.dart';

class CartModel {
  CartModel({
    this.id,
    this.name,
    this.image,
    this.price,
    this.hasAddon,
    this.quantity,
    this.isExist,
    this.time,
    // this.adons,
    this.product,
  });
  int? id;
  String? name;
  String? image;
  int? price;
  bool? hasAddon;
  int? quantity;
  bool? isExist;
  String? time;
  // List<Adon>? adons;
  ProductModel? product;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        hasAddon: json["hasAddon"],
        quantity: json["quantity"],
        isExist: json["isExist"],
        time: json["time"],
        // adons: List<Adon>.from(json["adons"].map((x) => Adon.fromJson(x))),
        product: ProductModel.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "hasAddon": hasAddon,
        "quantity": quantity,
        "isExist": isExist,
        "time": time,
        "product": product!.toJson()
        // "adons": List<dynamic>.from(adons!.map((x) => x.toJson())),
        // "restaurant": restaurant!.toJson(),
      };
}

class Adon {
  Adon({
    this.id,
    this.name,
    this.price,
  });
  int? id;
  String? name;
  int? price;

  factory Adon.fromJson(Map<String, dynamic> json) => Adon(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.location,
    this.logo,
  });
  int? id;
  String? name;
  String? location;
  String? logo;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "logo": logo,
      };
}
