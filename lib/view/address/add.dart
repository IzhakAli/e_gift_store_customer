import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/address/add_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';

class AddressAdd extends StatelessWidget {
  const AddressAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddAddressController controllerpage = Get.put(AddAddressController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
      ),
      body: Container(
        child: GetBuilder<AddAddressController>(
            builder: ((controllerpage) => HandlingDataView(
                statusRequest: controllerpage.statusRequest,
                widget: Column(children: [
                  if (controllerpage.kGooglePlex != null)
                    Expanded(
                        child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          markers: controllerpage.markers.toSet(),
                          onTap: (latlong) {
                            controllerpage.addMarkers(latlong);
                          },
                          initialCameraPosition: controllerpage.kGooglePlex!,
                          onMapCreated: (GoogleMapController controllermap) {
                            controllerpage.completercontroller!
                                .complete(controllermap);
                          },
                        ),
                        Positioned(
                          bottom: 10,
                          child: Container(
                            child: MaterialButton(
                              minWidth: 200,
                              onPressed: () {
                                controllerpage.lat == null
                                    ? showLocationDialog()
                                    : controllerpage
                                        .goToPageAddDetailsAddress();
                              },
                              color: AppColor.primary,
                              textColor: Colors.white,
                              child: const Text("Finish",
                                  style: TextStyle(fontSize: 18)),
                            ),
                          ),
                        )
                      ],
                    ))
                ])))),
      ),
    );
  }
}

void showLocationDialog() {
  Get.dialog(
    AlertDialog(
      title: const Text('Choose Location'),
      content: const Text('Please choose your location before proceeding.'),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay'),
          onPressed: () {
            Get.back(); // Close the dialog
          },
        ),
      ],
    ),
    barrierDismissible: false, // User must tap a button to close the dialog
  );
}
