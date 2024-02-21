import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../controller/orders/tracking_controller.dart';
import '../../../core/class/handlingdataview.dart';

class OrdersTracking extends StatelessWidget {
  const OrdersTracking({super.key});

  @override
  Widget build(BuildContext context) {
    TrackingController controller2 = Get.put(TrackingController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking'),
      ),
      body: Container(
        child: GetBuilder<TrackingController>(
          builder: ((controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Stack(
                  children: [
                    GoogleMap(
                      polylines: controller.polylineSet,
                      mapType: MapType.normal,
                      markers: controller.markers.toSet(),
                      initialCameraPosition: controller.cameraPosition ??
                          CameraPosition(
                            target: LatLng(0.0, 0.0), // Default coordinates
                            zoom: 12.4746,
                          ),
                      onMapCreated: (GoogleMapController controllermap) {
                        controller.gmc = controllermap;
                      },
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
