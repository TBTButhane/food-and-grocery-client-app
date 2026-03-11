// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:shop4you/Controllers/auth_controller.dart';
import 'package:shop4you/Controllers/location_controller.dart';
import 'package:shop4you/models/address_model.dart';
import 'package:shop4you/routes/route_helper.dart';
import 'package:shop4you/screens/pick_address_page.dart';

import 'package:shop4you/widgets/app_text_field.dart';
import 'package:shop4you/widgets/appicon.dart';
import 'package:shop4you/widgets/big_text.dart';

import 'package:shop4you/widgets/dimentions.dart';

class AddressPage extends StatefulWidget {
  final String page;
  const AddressPage({Key? key, required this.page}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _contactPersonController =
      TextEditingController();
  final TextEditingController _contactPersonNumberController =
      TextEditingController();
  late bool _isLogged;

  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(-23.4013, 29.4179), zoom: 17);
  LatLng _initialPosition = LatLng(-23.4013, 29.4179);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //TODO: check if user is loggin and also the userMOdel is not empty
    _isLogged = Get.find<AuthController>().isLoggedIn();

    if (_isLogged && Get.find<AuthController>().savedDatalocally()) {
      Get.find<AuthController>().getUserdata();
      Get.find<LocationController>().getAddressList();
    } else {
      return;
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          " ") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }

      Get.find<LocationController>().getUserAddress();

      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().addressList[0].latitude),
              double.parse(
                  Get.find<LocationController>().addressList[0].longitude)),
          zoom: 17);

      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().addressList[0].latitude),
          double.parse(
              Get.find<LocationController>().addressList[0].longitude));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              if (widget.page == "signUp") {
                Get.toNamed(RouteHelper.getIntialPage());
              } else if (widget.page == "cart page") {
                Get.back();
              } else {
                Get.back();
              }
            },
            icon: AppIcon(
              icon: Icons.arrow_back_ios,
              iconColor: Colors.white,
              backgroundColor: Colors.transparent,
              size: Dimensions.iconSize24,
              iconSize: Dimensions.iconSize24,
            )),
        title: const BigText(
            text: "Choose Address",
            fontColor: Colors.white,
            fontSize: 18,
            isBold: true),
      ),
      body: GetBuilder<AuthController>(builder: (authController) {
        if (authController.storedUserDetails != null &&
            _contactPersonController.text.isEmpty) {
          _contactPersonController.text =
              authController.storedUserDetails!.name;
          _contactPersonNumberController.text =
              authController.storedUserDetails!.phoneNumber;
          if (Get.find<LocationController>().addressList.isNotEmpty) {
            _addressController.text =
                Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController) {
          _addressController.text = '${locationController.placeMark.name ?? ""}'
              ' ${locationController.placeMark.locality ?? ""}'
              '${locationController.placeMark.postalCode ?? ""}'
              '${locationController.placeMark.country ?? ""}';
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15 - 8),
                            border: Border.all(width: 2, color: Colors.green)),
                        child: Stack(
                          children: [
                            GoogleMap(
                              onTap: (latLan) {
                                Get.toNamed(RouteHelper.pickAddressPage(),
                                    arguments: PickAddressPage(
                                      fromAddress: true,
                                      fromSignup: false,
                                      googleMapController:
                                          locationController.mapController,
                                    ));
                              },
                              initialCameraPosition: CameraPosition(
                                  target: _initialPosition, zoom: 17),
                              indoorViewEnabled: true,
                              zoomControlsEnabled: false,
                              compassEnabled: false,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              mapToolbarEnabled: false,
                              onCameraIdle: () {
                                locationController.updatePosition(
                                    _cameraPosition, true);
                              },
                              onCameraMove: (position) {
                                _cameraPosition = position;
                              },
                              onMapCreated:
                                  (GoogleMapController mapcontroller) {
                                // requestPermision();
                                locationController
                                    .setMapController(mapcontroller);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Row(
                    children: List.generate(
                        locationController.addressTypeList.length,
                        (index) => InkWell(
                              onTap: () {
                                locationController.setAddressTypeIndex(index);
                              },
                              child: Container(
                                height: 55,
                                width: 55,
                                margin: EdgeInsets.only(
                                    right: Dimensions.width10 - 3, left: 0),
                                child: Card(
                                  child: Center(
                                    child: Icon(
                                        index == 0
                                            ? Icons.home
                                            : index == 1
                                                ? Icons.work
                                                : Icons.location_on,
                                        color: locationController
                                                    .addressTypeIndex ==
                                                index
                                            ? Colors.green
                                            : Colors.grey,
                                        size: 35),
                                  ),
                                ),
                              ),
                            )),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Card(
                    margin: EdgeInsets.all(0),
                    child: AppTextField(
                      icon: Icons.location_on,
                      textInputSize: 0,
                      controller: _addressController,
                      hintText: "Your location",
                      type: TextInputType.streetAddress,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Card(
                    margin: EdgeInsets.all(0),
                    child: AppTextField(
                      icon: Icons.person,
                      textInputSize: 0,
                      controller: _contactPersonController,
                      hintText: _contactPersonController.text,
                      type: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Card(
                    margin: EdgeInsets.all(0),
                    child: AppTextField(
                      icon: Icons.phone,
                      textInputSize: 0,
                      controller: _contactPersonNumberController,
                      hintText: _contactPersonNumberController.text,
                      type: TextInputType.text,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      }),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: Dimensions.height45 + Dimensions.height30,
                  padding:
                      EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: GestureDetector(
                    onTap: () {
                      AddressModel _addressModel = AddressModel(
                          addressType: controller
                              .addressTypeList[controller.addressTypeIndex],
                          address: controller.getAddress['formatted_address'],
                          contactNumber: _contactPersonController.text,
                          contactPerson: _contactPersonNumberController.text,
                          latitude: controller.position.latitude.toString(),
                          longitude: controller.position.longitude.toString());
                      controller.addAddress(_addressModel);
                    },
                    child: Center(
                      child: Container(
                        // height: 50,
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 15, right: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.shade400),
                        child: Text("Save Address",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15)),
                      ),
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}
