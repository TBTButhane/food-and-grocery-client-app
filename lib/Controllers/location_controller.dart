import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop4you/models/address_model.dart';
import 'package:shop4you/models/response_model.dart';
import 'package:shop4you/util/api_checker.dart';
import 'package:shop4you/util/location_repo.dart';
import 'package:shop4you/util/app_const.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  List<AddressModel> _addressList = [];
  List<AddressModel> _allAddressList = [];
  final List<String> _addressTypeList = ["Home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  late Map<String, dynamic> _getAddress;
  late AddressModel _addressModel;
  AddressModel get getAddressModel => _addressModel;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  Placemark get placeMark => _placemark;
  Placemark get pickPlaceMark => _pickPlacemark;
  List<AddressModel> get addressList => _addressList;
  List<AddressModel> get allAddressList => _allAddressList;
  int get addressTypeIndex => _addressTypeIndex;
  Map get getAddress => _getAddress;
  // late String lat;
  // late String lng;

  // final FirebaseFirestore _fFireStore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  bool _updateAdressPosition = true;
  bool _changeAddress = true;

  List<Prediction> _predictionList = [];
  List<Prediction> get predictionList => _predictionList;

//for service zone
  bool _isLoading = false;

  bool get isLoading => _isLoading;

//where the user is in service zone
  bool _inZone = false;

  bool get inZone => _inZone;

  // showing and hiding button as the map loads
  bool _buttonDisabled = true;

  bool get buttonDisabled => _buttonDisabled;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
    update();
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAdressPosition) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }
        //TODO: check the response model
        ResponseModel _responseModel = await getZone(
            position.target.latitude.toString(),
            position.target.longitude.toString(),
            true);
        _buttonDisabled = !_responseModel.isSuccess;
        if (_changeAddress) {
          String _address = await getAddressFromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        } else {
          _changeAddress = true;
        }
      } catch (e) {
        print(e);
      }
      _loading = false;
      update();
    } else {
      _updateAdressPosition = true;
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = "unknown location found";
    Response response = await locationRepo.getAddressFromGeocode(latLng);
    if (response.body["status"] == 'OK') {
      _getAddress = response.body["results"][0];
      _address = response.body["results"][0]['formatted_address'].toString();
      print(_getAddress['formatted_address']);
    } else {
      print("Error getting the google api");
    }
    return _address;
  }

  Future<void> addAddress(AddressModel addressModel) async {
    final sharedPreferences = await _sharedPreferences;
    _loading = true;
    _addressList = [];
    update();
    await locationRepo.addUserAddress(addressModel);
    // var getRef = _fFireStore.collection("users").doc(_auth.currentUser!.uid);
    String saveAddress = jsonEncode(addressModel.toJson());
    sharedPreferences.setString(userAddress, saveAddress);
    _addressList.add(addressModel);
    _loading = false;
    update();
  }

  AddressModel getUserAddress() {
    // late AddressModel _addressModel;
    // _getAddress = jsonDecode(locationRepo.getUserAddress());
    _loading = true;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    update();
    try {
      _addressModel = AddressModel.fromJson(_getAddress);
    } catch (e) {
      print(e);
    }
    _loading = false;
    update();
    return _addressModel;
  }

  Future<void> getAddressList() async {
    final List<AddressModel> _addresses = await locationRepo.getAllAddress();
    if (_addresses.isNotEmpty) {
      _addressList = [];
      _allAddressList = [];
      for (var address in _addresses) {
        _addressList.add(address);
        _allAddressList.add(address);
        print(_addressList);
      }
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  void setAddAddrassData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();
    Response response = await locationRepo.getZone(lat, lng);
    if (response.statusCode == 200) {
      _inZone = true;
      _responseModel = ResponseModel(true, response.body["zone_id"].toString());
    } else {
      _inZone = false;
      _responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return _responseModel;
  }
  //TODO: work on this

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddressFromLocalStorage();
  }

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      Response response = await locationRepo.searchLocation(text);
      if (response.statusCode == 200 && response.body['status'] == "OK") {
        _predictionList = [];
        response.body['predictions'].forEach((prediction) =>
            _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }

  setLocation(
      String placeId, String address, GoogleMapController mapController) async {
    _loading = true;
    update();
    PlacesDetailsResponse details;
    Response response = await locationRepo.setLocation(placeId);
    if (response.statusCode == 200) {
      details = PlacesDetailsResponse.fromJson(response.body);
      _pickPosition = Position(
          longitude: details.result.geometry!.location.lng,
          latitude: details.result.geometry!.location.lat,
          timestamp: DateTime.now(),
          accuracy: 1,
          altitude: 1,
          heading: 1,
          speed: 1,
          speedAccuracy: 1);
      _pickPlacemark = Placemark(name: address);
      _changeAddress = false;
      if (!mapController.isNull) {
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(details.result.geometry!.location.lat,
                    details.result.geometry!.location.lng),
                zoom: 17)));
      }
      _loading = false;
      update();
    }
  }
}
