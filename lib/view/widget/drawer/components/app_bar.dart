import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin/controller/home_controller.dart';
import 'package:skin/core/class/statusrequest.dart';
import 'package:skin/core/constant/color.dart';
import 'package:skin/core/shared/shimmer_effect.dart';
import '../../../../core/shared/spacing_widgets.dart';

class DrawerAppBar extends StatelessWidget {
  const DrawerAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder:(controller) =>  Row(
        children: <Widget>[
          const CircleAvatar(
            backgroundColor: AppColor.white,
            child: Icon(Icons.person,color: AppColor.primaryColor,),
          ),
          addHorizontalSpace(18.0),
          controller.statusRequest==StatusRequest.none?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               Text(
                 controller.name,
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              addVerticalSpace(5.0),
              Text(
                controller.mobile,
                style:TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[200],
                ),
              ),
            ],
          ):
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               ShimmerEffect(width: Get.width/3, height: 10, radius: 5),
              addVerticalSpace(5.0),
              ShimmerEffect(width: Get.width/3, height: 10, radius: 5),

            ],
          ),
        ],
      ),
    );
  }
}
