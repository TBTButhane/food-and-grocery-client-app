import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop4you/models/address_model.dart';
import 'package:shop4you/util/apiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop4you/util/app_const.dart';

import '../widgets/custome_snackbar.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  final FirebaseFirestore _fFireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressFromGeocode(LatLng latLng) async {
    return await apiClient.getData(
        '/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$mkey');
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData(
        // '/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$mkey');
        '/maps/api/geocode/json?latlng=$lat,$lng&key=$mkey');
  }

  saveUserAddress(String addressModel) {
    sharedPreferences.setString(userAddress, addressModel);
  }

  String getUserAddressFromLocalStorage() {
    return sharedPreferences.getString(userAddress)!;
  }

  String getUserAddress() {
    return sharedPreferences.getString(userAddress) ?? "";
  }

  //Save User Address Locally and maybe to firebase
  Future<void> addUserAddress(AddressModel addressModel) async {
    var ref = _fFireStore.collection("users").doc(_auth.currentUser!.uid);
    var getRef = _fFireStore.collection("users").doc(_auth.currentUser!.uid);
    List<AddressModel> addressList = [];
    addressList.add(addressModel);
    //Check if data already exist, update data if exist/ add if it doesn't
    var data = await getRef.get();
    try {
      if(data.exists && data["address_list"] != Null){

        await ref.update({
          "address_list": addressList.map((e) => e.toJson()).toList()
        }).then((value) => shoeCustomSnackbar(
          "Delivery Address saved & updated",
          isError: false,
          title: "Address updated",
        ));

    }else {
      await ref.set({
        "address_list": addressList.map((e) => e.toJson()).toList()
      }).then((value) => shoeCustomSnackbar(
        "Delivery Address saved",
        isError: false,
        title: "Address Saved",
      ));
    }
  } catch (e) {
    print(e.toString());
    }

  }

  Future<List<AddressModel>> getAllAddress() async {
    var ref = _fFireStore.collection("users").doc(_auth.currentUser!.uid);
    final getAllAddress = await ref.get();
    final userAddress = getAllAddress.data();
    late List<AddressModel> data;
    if (userAddress != null) {
      List addressList = jsonDecode(jsonEncode(userAddress["address_list"]));
      data =
          addressList.map((address) => AddressModel.fromJson(address)).toList();
    }
    return data;
  }

  Future<Response> searchLocation(String text) async {
    return await apiClient.getData(
        '/maps/api/place/autocomplete/json?input=$text&key=$mkey&sessiontoken=1234567890&components=country:ZA');
  }

  Future<Response> setLocation(String placeId) async {
    return await apiClient
        .getData('/maps/api/place/details/json?place_id=$placeId&key=$mkey');
  }
}
