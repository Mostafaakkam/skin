import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/shared/spacing_widgets.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key,
    required this.diagnosisTap,
     required this.savedTap,
    required this.clinicTap,
    required this.selected});
 final void Function() diagnosisTap;
 final void Function() savedTap;
 final void Function() clinicTap;

 final int selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: diagnosisTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Row(
              children: <Widget>[
                 FaIcon(
               Icons.add_box_rounded,
                  color: selected==0?Colors.white:Colors.grey[400],
                ),
                addHorizontalSpace(15.0),
                Text(
                  "التشخيص",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: selected==0?Colors.white:Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: savedTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Row(
              children: <Widget>[
                Icon(
                 Icons.save,
                  color: selected==1?Colors.white:Colors.grey[400],
                ),
                addHorizontalSpace(15.0),
                Text(
                  'المحفوظات',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: selected==1?Colors.white:Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: clinicTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Row(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.userDoctor,
                  color: selected==2?Colors.white:Colors.grey[400],
                ),
                addHorizontalSpace(15.0),
                Text(
                  "العيادات",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: selected==2?Colors.white:Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
