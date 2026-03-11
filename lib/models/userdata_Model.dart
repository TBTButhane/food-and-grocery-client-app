// import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  // final String id;
  final String name, email;
  String? address;
  final String phoneNumber;

  UserDetails({
    // required this.id,
    required this.name,
    required this.email,
    this.address,
    required this.phoneNumber,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
      // id : json["id"],
      name: json["name"],
      email: json["email"],
      address: json["address"] ?? "",
      phoneNumber: json["phone"]);

  Map<String, Object?> toJson() => {
        // "id": id,
        "name": name,
        "email": email,
        "address": address ?? "",
        "phone": phoneNumber,
      };
}
