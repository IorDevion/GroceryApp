import 'package:GroceryApp/color.dart';
import 'package:GroceryApp/model/CartModel.dart';
import 'package:GroceryApp/model/getProduct.dart';
import 'package:GroceryApp/sizeConfig.dart';
import 'package:GroceryApp/widgets/component/backButton.dart';
import 'package:GroceryApp/widgets/component/cartButton.dart';
import 'package:GroceryApp/widgets/component/default_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/component/LikeButton.dart';
import '../model/getProduct.dart';

class DetailProduct extends StatefulWidget {
  static String routeName = '/detail';
  const DetailProduct({Key key}) : super(key: key);

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  CollectionReference productItem = FirebaseFirestore.instance.collection('productItem');

  String id; 
  
  @override
  initState() {
    id = Get.arguments as String; 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: FutureBuilder<DocumentSnapshot>(
              future: productItem.doc(id).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                print(snapshot);
                if(snapshot.connectionState == ConnectionState.done){
                  Map<String, dynamic> data = snapshot.data.data();
                   return Column(
                    children: <Widget>[
                      SizedBox(height: getFlexibleHeight(5)),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrevButton(),
                            CartButton(),
                          ],
                        ),
                      ),
                      SizedBox(height: getFlexibleHeight(5)),
                      Container(
                        width: getFlexibleWidth(200),
                        height: getFlexibleHeight(300),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                        ),
                        child: ClipRRect(
                            //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                            child: Image.network(
                                '${data['img']}')),
                      ),
                      SizedBox(
                        height: getFlexibleHeight(50),
                      ),
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Color(hexColor('#ebebeb')).withOpacity(0.5),
                                spreadRadius: 1,
                                offset: Offset(1, -3),
                                blurRadius: 1,
                              )
                            ]),
                        child: Stack(
                          children: [
                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              getFlexibleWidth(30),
                                              getFlexibleHeight(25),
                                              getFlexibleWidth(0),
                                              getFlexibleHeight(10)
                                              ),
                                          child: Text(
                                            // '\$${productItem.data[""]}',
                                            '\$${data['price']}',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color(hexColor('#5938ff'))),
                                          )),
                                    ),
                                    LikeButton(),
                                    // IconButton(
                                    //   ic
                                    // )
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(left:getFlexibleWidth(20)),
                                  child : Text(data['name'],
                                  style:GoogleFonts.montserrat(
                                    fontSize:20,
                                    color: Color(hexColor('#7578ff'))
                                  ))
                                ),
                                SizedBox(
                                  height: getFlexibleHeight(20),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: getFlexibleWidth(20)),
                                  child: Text(data['desc'],
                                  style: GoogleFonts.montserrat(
                                    fontSize:15,
                                    color:Color(hexColor('#c2c3ff') )
                                  ),),
                                ),
                                SizedBox(
                                  height: getFlexibleWidth(70),
                                ),
                              ],
                            ),
                             Align(
                               alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                child: DefaultButton(text: 'Add to cart',),
                                onTap: (){
                                    AddtoCart(
                                      name: data['name'],
                                      price: data['price'],
                                      qty: 1,
                                      total: data['price'] * 1,
                                    ).addCart();
                                    print('Masuk');
                                    Get.toNamed('/cart');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                        SizedBox(height: getFlexibleHeight(20),)
                    ],
                  );
                } else if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: 
                  Text('Loading',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Color(hexColor('#3034ff')
                  ))));
                }else{
                  return Center(child: 
                  Text('Something Went Wrong',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Color(hexColor('#3034ff')
                  ))));
                }
              },
            ), 
          ),
        ),
      ),
    );
  }
}
