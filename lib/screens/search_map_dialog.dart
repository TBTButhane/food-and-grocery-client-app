// ignore_for_file: no_leading_underscores_for_local_identifiers, implementation_imports, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop4you/Controllers/location_controller.dart';
import 'package:shop4you/widgets/dimentions.dart';
import 'package:google_maps_webservice/src/places.dart';

class SearchMapDialog extends StatelessWidget {
  final GoogleMapController mapController;
  const SearchMapDialog({Key? key, required this.mapController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimensions.width20),
      alignment: Alignment.topCenter,
      child: Material(
        borderRadius: BorderRadius.circular(Dimensions.radius20 / 2),
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 15),
                  isDense: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  // labelText: widget.helpText,
                  hintText: 'Search location',
                  labelStyle: const TextStyle(
                    color: Color(0xff5B5B5B),
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                )),
            onSuggestionSelected: (Prediction suggestion) async {
              await Get.find<LocationController>().setLocation(
                  suggestion.placeId!, suggestion.description!, mapController);
              Get.back();
            },
            suggestionsCallback: (String pattern) async {
              return await Get.find<LocationController>()
                  .searchLocation(context, pattern);
            },
            itemBuilder: (BuildContext context, Prediction? itemData) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(Icons.location_pin),
                    Expanded(
                        child: Text(
                      itemData!.description.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                    const Divider(
                      color: Colors.black,
                      thickness: 5,
                      endIndent: 5,
                      indent: 5,
                      height: 2,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
