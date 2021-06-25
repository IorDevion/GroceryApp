import 'package:GroceryApp/widgets/icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import '../../color.dart';
import '../../sizeConfig.dart';

class ButtonList extends StatelessWidget {
  const ButtonList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(hexColor('#aaa1ff')),
        borderRadius: BorderRadius.circular(7)
      ),
      margin: EdgeInsets.only(right:getFlexibleWidth(20)),
      padding: EdgeInsets.symmetric(vertical:getFlexibleWidth(7),horizontal:getFlexibleHeight(7)),
      child: Icon(MyFlutterApp.th_thumb,
      color: Color(hexColor('#3621ff')),),
    );
  }
}