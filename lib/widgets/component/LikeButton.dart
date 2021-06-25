import 'package:GroceryApp/widgets/icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

import '../../color.dart';
import '../../sizeConfig.dart'; 

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right:getFlexibleWidth(20)),
      child: IconButton(
        icon:Icon(MyFlutterApp.heart_empty),
        iconSize: 20,
        color: Color(hexColor('#5938ff')),
        onPressed: (){
          //
        },
      )
    );
  }
}
