import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/class/cache_helper.dart';
import '../../core/class/statusrequest.dart';

class LocationController extends GetxController {
  late Completer<GoogleMapController> googleMapController;
  CameraPosition? cameraPosition;

  late LatLng clinicLocation;
  late LatLng userLocation;
  Set<Marker> markers = {};

  StatusRequest locationStatusRequest = StatusRequest.loading;

  @override
  void onInit() async {
    await initialData();
    super.onInit();
  }

  Future<void> initialData() async {
    googleMapController = Completer();
    // 1. استلام موقع العيادة من Get.arguments
    final String clinicLocString = Get.arguments['location']??"0,0"; // مثال: "33.5138,36.2765"
    print("======ttt$clinicLocString");
     if(clinicLocString!=""){
    clinicLocation = LatLng(
      double.parse(clinicLocString.split(',')[0]),
      double.parse(clinicLocString.split(',')[1]),
    );}
    print(clinicLocString);

    // 2. جلب موقع المستخدم من الكاش
    final String userLocString = await CacheHelper.getData(key: 'user_location')??"0,0";
    if(userLocString!=""){
    userLocation = LatLng(
      double.parse(userLocString.split(',')[0]),
      double.parse(userLocString.split(',')[1]),
    );}
    print(userLocString);


    // 3. إعداد المركز المبدئي للكاميرا بين النقطتين
    double midLat = (clinicLocation.latitude + userLocation.latitude) / 2;
    double midLng = (clinicLocation.longitude + userLocation.longitude) / 2;

    cameraPosition = CameraPosition(
      target: LatLng(midLat, midLng),
      zoom: 13,
    );

    // 4. إضافة العلامات (markers)
    markers.addAll([
      Marker(
        markerId: const MarkerId("clinic"),
        position: clinicLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: "موقع العيادة"),
      ),
      Marker(
        markerId: const MarkerId("user"),
        position: userLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: "موقعك الحالي"),
      ),
    ]);
    locationStatusRequest=StatusRequest.none;
    update();
  }
}
