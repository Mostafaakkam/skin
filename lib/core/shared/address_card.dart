import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../constant/color.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.address, required this.location});
   final String address;
   final String location;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Get.toNamed(AppRoute.locationPage,arguments: {
      //   'location':location
      // }),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: Get.width*.85,

          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 10
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  location,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),

                ),
              ),
              const Spacer(),
              const Icon(FontAwesomeIcons.mapLocation,color: AppColor.primaryColor,),

            ],
          ),
        ),
      ),
    );
  }
}
