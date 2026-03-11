class RestaurantsModel {
  String? id;
  String? name;
  String? logo;
  String? location;
  RestaurantsModel({this.id, this.name, this.logo, this.location});
  RestaurantsModel.fromJson(Map<String, dynamic> data) {
    id = data["id"] ?? "";
    name = data["name"] ?? "";
    logo = data["logo"] ?? "";
    location = data["location"] ?? "";
  }
  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "logo": logo, "location": location};
}
