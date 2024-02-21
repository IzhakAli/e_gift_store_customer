import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/getdecodepolyline.dart';
import '../../core/services/services.dart';
import '../../data/model/ordersmodel.dart';

class TrackingController extends GetxController {
  MyServices myServices = Get.find();

  Set<Polyline> polylineSet = {};

  GoogleMapController? gmc;

  List<Marker> markers = [];

  late StatusRequest statusRequest = StatusRequest.none;

  late OrdersModel ordersModel;

  double? destlat;
  double? destlong;

  double? currentlat;
  double? currentlong;

  CameraPosition? cameraPosition;

  initialData() {
    if (ordersModel.addressLat != null && ordersModel.addressLong != null) {
      cameraPosition = CameraPosition(
        target: LatLng(ordersModel.addressLat!, ordersModel.addressLong!),
        zoom: 12.4746,
      );

      markers.add(Marker(
        markerId: MarkerId("current"),
        position: LatLng(ordersModel.addressLat!, ordersModel.addressLong!),
      ));
    } else {
      print(
          "The longtitude and latitude passed from the ordersModel are NULL!");
    }
  }

  initPolyline() async {
    destlat = ordersModel.addressLat;
    destlong = ordersModel.addressLong;
    await Future.delayed(Duration(seconds: 1));

    polylineSet = await getPolyline(currentlat, currentlong, destlat, destlong);
    update();
  }

  getLocationDelivery() {
    FirebaseFirestore.instance
        .collection("delivery")
        .doc(ordersModel.ordersId.toString())
        .snapshots()
        .listen((event) {
      if (event.exists) {
        destlat = double.parse(event.get("lat"));
        destlong = double.parse(event.get("long"));
        updateMarkerDelivery(destlat!, destlong!);
      }
    });
  }

  updateMarkerDelivery(double newlat, double newlong) {
    markers.removeWhere((element) => element.markerId.value == "dest");
    markers.add(
        Marker(markerId: MarkerId("dest"), position: LatLng(newlat, newlong)));
    update();
  }

  @override
  void onInit() {
    super.onInit();
    ordersModel = Get.arguments['ordersModel'];
    print(ordersModel.addressLat);
    print(ordersModel.addressLong);

    initialData();
    getLocationDelivery();

    // initPolyline();
  }

  @override
  void onClose() {
    gmc?.dispose();
    super.onClose();
  }
}
