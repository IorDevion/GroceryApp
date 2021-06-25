import 'package:GroceryApp/color.dart';
import 'package:GroceryApp/sizeConfig.dart';
import 'package:GroceryApp/widgets/component/backButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  static String routeName = '/cart';
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CollectionReference cart =
      FirebaseFirestore.instance.collection('cartProduct');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PrevButton(),
                    SizedBox(
                      width: getFlexibleWidth(20),
                    ),
                    Container(
                      child: Center(
                          child: Text(
                        'Cart Shopping',
                        style: GoogleFonts.montserrat(
                            fontSize: 20, color: Color(hexColor('#4d4fff'))),
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: getFlexibleHeight(20),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getFlexibleWidth(5),
                  ),
                  child: Container(
                    width: double.infinity,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: cart.snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          //print(snapshot.data.docs.length);
                          return new ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext ctx, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: getFlexibleHeight(10),
                                  horizontal: getFlexibleWidth(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: getFlexibleHeight(20),
                                  horizontal: getFlexibleWidth(20),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Color(hexColor('#bac1ff'))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: getFlexibleWidth(100),
                                          height: getFlexibleHeight(125),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image(
                                                image: NetworkImage(snapshot
                                                    .data.docs[index]['img']),
                                                fit: BoxFit.fill,
                                              )),
                                        ),
                                        SizedBox(
                                          width: getFlexibleWidth(20),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: getFlexibleHeight(20),
                                            ),
                                            Container(
                                                child: Text(
                                              snapshot.data.docs[index]['name'],
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  color: Color(
                                                      hexColor('#5e6eff'))),
                                            )),
                                            Container(
                                              child: Text(
                                                snapshot
                                                    .data.docs[index]['price']
                                                    .toString(),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 15,
                                                    color: Color(
                                                        hexColor('#5e6eff')),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  IconButton(
                                                    onPressed: () {
                                                      //
                                                    },
                                                    icon: Icon(Icons
                                                        .indeterminate_check_box_outlined),
                                                    iconSize: 20,
                                                    color: Color(
                                                        hexColor('#5969ff')),
                                                  ),
                                                  Text(
                                                  snapshot
                                                      .data.docs[index]['qty']
                                                      .toString(),
                                                  style:
                                                      GoogleFonts.montserrat(
                                                    color: Color(hexColor('#5e6eff')),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      //
                                                    },
                                                    icon: Icon(
                                                        Icons.add_box_outlined),
                                                    color: Color(
                                                        hexColor('#5969ff')),
                                                    iconSize: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: snapshot.data.docs.length,
                          );
                          // return Card(
                          //   child : Text('asd')
                          // );
                        } else {
                          return Center(child: Text('Loading...'));
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
