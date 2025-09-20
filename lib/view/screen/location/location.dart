
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../controller/location/location_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());

    return GetBuilder<LocationController>(
      builder: (controller) {


        return Scaffold(
          appBar: AppBar(
            title: const Text("الموقع",style: TextStyle(color: Colors.white),),
            backgroundColor: AppColor.primaryColor,
          ),
          body:controller.cameraPosition!=null? GoogleMap(
            initialCameraPosition: controller.cameraPosition!,
            mapType: MapType.normal,
            markers: controller.markers,
            onCameraMove: (position) {
              // ممكن استخدامه لاحقًا
            },
            onMapCreated: (GoogleMapController c) {
              if (!controller.googleMapController.isCompleted) {
                controller.googleMapController.complete(c);
              }
            },
          ):
          Center(child: CircularProgressIndicator(color: AppColor.primaryColor,),),
        );
      },
    );
  }
}

