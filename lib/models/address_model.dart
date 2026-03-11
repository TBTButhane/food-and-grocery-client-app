class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPerson, _contactNumber;
  late String _address, _latitude, _longitude;

  AddressModel(
      {id,
      required addressType,
      contactPerson,
      contactNumber,
      address,
      latitude,
      longitude}) {
    _id = id;
    _addressType = addressType;
    _contactPerson = contactPerson;
    _contactNumber = contactNumber;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }

  String get addressType => _addressType;
  String? get contactPerson => _contactPerson;
  String? get contactNumber => _contactNumber;
  String get address => _address;
  String get latitude => _latitude;
  String get longitude => _longitude;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['address_type'] ?? '';
    _contactPerson = json['person_name'] ?? '';
    _contactNumber = json['person_number'] ?? '';
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = _id;
    data["address"] = _address;
    data["person_name"] = _contactPerson;
    data["person_number"] = _contactNumber;
    data["address_type"] = _addressType;
    data["latitude"] = _latitude;
    data["longitude"] = _longitude;

    return data;
  }
}
