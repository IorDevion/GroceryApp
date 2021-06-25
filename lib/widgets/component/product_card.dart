import 'package:GroceryApp/color.dart';
import 'package:GroceryApp/model/productItem.dart';
import 'package:GroceryApp/widgets/icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../detail_product.dart';

import '../../sizeConfig.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    @required this.product,
    Key key,
  }) : super(key: key);

  final ProductItem product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(DetailProduct.routeName, arguments: product.id);
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getFlexibleHeight(30)),
                Container(
                    child: Center(
                      child: Image.network(
                        product.img,
                        fit: BoxFit.fill,
                        width: getFlexibleWidth(70),
                        height: getFlexibleHeight(80),
                      ),
                    ),
                  ),
            SizedBox(height: getFlexibleHeight(30)),
            Container(
              decoration: BoxDecoration(
                  color: Color(hexColor('#ebecff')),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Column(
                children: [
                  Container(
                  padding: EdgeInsets.only(top: getFlexibleHeight(15)),
                  child: Center(
                    child: Text(
                      product.name,
                      style: GoogleFonts.montserrat(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(hexColor('#5e6aff'))),
                    ),
                  ),
                ),
                  // SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: getFlexibleWidth(20)),
                        child: Text(
                          '\$${product.price}',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: Color(hexColor('#5e6aff')),
                              fontSize: 15),
                        ),
                      ),
                      IconButton(
                      color: Color(hexColor('#5e6aff')),
                      icon: Icon(MyFlutterApp.right_open),
                      splashColor: Colors.transparent,
                      onPressed: () {
                        Get.toNamed(DetailProduct.routeName, arguments: product.id);
                      })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Color(hexColor('#d6d9ff')),
          borderRadius: BorderRadius.circular(15),
          // boxShadow: [
          //   BoxShadow(
          //     color:Colors.grey.withOpacity(0.2),
          //     spreadRadius: 1,
          //     blurRadius: 1,
          //     offset: Offset(0,3)
          //   )
          // ]
        ),
      ),
    );
  }
}
