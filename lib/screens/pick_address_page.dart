// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop4you/Controllers/location_controller.dart';
import 'package:shop4you/routes/route_helper.dart';
import 'package:shop4you/screens/search_map_dialog.dart';
import 'package:shop4you/widgets/big_text.dart';
import 'package:shop4you/widgets/custom_button.dart';
import 'package:shop4you/widgets/dimentions.dart';

class PickAddressPage extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;

  final GoogleMapController? googleMapController;
  const PickAddressPage({
    Key? key,
    required this.fromSignup,
    required this.fromAddress,
    this.googleMapController,
  }) : super(key: key);

  @override
  _PickAddressPageState createState() => _PickAddressPageState();
}

class _PickAddressPageState extends State<PickAddressPage> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    //TODO: for test purpose
    _initialPosition = LatLng(-25.3903, 28.2673);
    // _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);

    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(-25.3903, 28.2673);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(
                Get.find<LocationController>().addressList[0].latitude),
            double.parse(
                Get.find<LocationController>().addressList[0].longitude));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
            child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                  onCameraIdle: () {
                    Get.find<LocationController>()
                        .updatePosition(_cameraPosition, false);
                  },
                  onMapCreated: (GoogleMapController mapController) {
                    if (!widget.fromAddress) {
                      //TODO: check for this in vid 4
                      _mapController = widget.googleMapController!;
                    } else {
                      mapController =
                          Get.find<LocationController>().mapController;
                    }
                  },
                ),
                //TODO: Replace icon with image from assets
                Center(
                  child: !locationController.loading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                              ),
                              child: BigText(
                                  text: "PICK",
                                  fontColor: Colors.white,
                                  fontSize: 20),
                            ),
                            Icon(
                              Icons.location_on,
                              size: 35,
                              color: Colors.green,
                            ),
                          ],
                        )
                      : CircularProgressIndicator(),
                ),
                Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: GestureDetector(
                      onTap: () {
                        Get.dialog(SearchMapDialog(
                          mapController: _mapController,
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10),
                        height: Dimensions.height45 + 20,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20 / 2)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 25,
                            ),
                            Expanded(
                                child: Text(
                              locationController.pickPlaceMark.name ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font20,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ))
                          ],
                        ),
                      ),
                    )),
                Positioned(
                    bottom: (Dimensions.height45 * 2) + 10,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: locationController.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : CustomButton(
                            buttonText: locationController.inZone
                                ? widget.fromAddress
                                    ? "Pick Address"
                                    : "Pick Location"
                                : "Service not available in your area",
                            height: Dimensions.height45 + 10,
                            icon: Icons.location_on,
                            fontSize: Dimensions.font20,
                            onPressed: (locationController.buttonDisabled ||
                                    locationController.loading)
                                ? null
                                : () {
                                    if (locationController
                                                .pickPosition.latitude !=
                                            0 &&
                                        locationController.placeMark.name !=
                                            null) {
                                      if (widget.fromAddress) {
                                        if (widget.googleMapController !=
                                            null) {
                                          widget.googleMapController!.moveCamera(
                                              CameraUpdate.newCameraPosition(
                                                  CameraPosition(
                                                      target: LatLng(
                                                          locationController
                                                              .pickPosition
                                                              .latitude,
                                                          locationController
                                                              .pickPosition
                                                              .longitude))));
                                          locationController
                                              .setAddAddrassData();
                                        }
                                        Get.toNamed(RouteHelper.getAddress(""));
                                      }
                                    }
                                  },
                          ))
              ],
            ),
          ),
        )),
      );
    });
  }
}
