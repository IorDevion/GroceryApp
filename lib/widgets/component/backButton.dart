import 'package:GroceryApp/widgets/icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../color.dart';
import '../../sizeConfig.dart';

class PrevButton extends StatelessWidget {
  const PrevButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Color(hexColor('#4f3bff'))),
      margin: EdgeInsets.only(left: getFlexibleWidth(20)),
      padding: EdgeInsets.symmetric(vertical : getFlexibleHeight(8), horizontal : getFlexibleWidth(7)),
      child: Center(
        child: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(
          MyFlutterApp.left_open,
          color: Colors.white,
          size: 15,
          ),
        ),
      ),
    );
  }
}