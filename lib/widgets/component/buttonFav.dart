import 'package:GroceryApp/widgets/icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

import '../../color.dart';
import '../../sizeConfig.dart';

class ButtonFav extends StatelessWidget {
  const ButtonFav({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Color(hexColor('#6C63FF'))
      ),
      padding: EdgeInsets.symmetric(horizontal:getFlexibleWidth(7),vertical:getFlexibleHeight(7)),
      child: Icon(
        MyFlutterApp.heart_empty,
        color: Color(hexColor('#ffffff')),
      ),
    );
  }
}