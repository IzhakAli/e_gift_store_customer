import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../data/datasource/static/constants.dart';

Future getPolyline(lat, long, destlat, destlong) async {
  List<LatLng> polylineco = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Polyline> polylineSet = {};

  String url =
      "https://maps.googleapis.com/maps/api/directions/json?origin=$lat,$long&destination=$destlat,$destlong&key=$googleAPI_key";

  var response = await http.post(Uri.parse(url));

  var responsebody = jsonDecode(response.body);

  var point = responsebody['routes'][0]['overview_polyline']['points'];

  List<PointLatLng> result = polylinePoints.decodePolyline(point);

  if (result.isNotEmpty) {
    result.forEach((PointLatLng pointLatLng) {
      polylineco.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
    });
  }

  Polyline polyline = Polyline(
      polylineId: PolylineId("line"),
      color: Colors.blue,
      width: 5,
      points: polylineco);

  polylineSet.add(polyline);

  return polylineSet;
}
