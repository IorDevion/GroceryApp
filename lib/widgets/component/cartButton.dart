import 'package:GroceryApp/color.dart';
import 'package:GroceryApp/widgets/icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../sizeConfig.dart';

class CartButton extends StatelessWidget {
  const CartButton({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right:getFlexibleWidth(20)),
      //child: Text('Hello World'),
      child: IconButton(
        icon: Icon(MyFlutterApp.basket),
        onPressed: (){
          print('Cart');
          Get.toNamed('/cart');
        },
        color:Color(hexColor('#4f3bff')),
       ),
    );
  }
}