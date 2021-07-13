import 'dart:io';
import 'package:GroceryApp/color.dart';
import 'package:GroceryApp/model/checkOutModel.dart';
import 'package:GroceryApp/model/deleteCart.dart';
import 'package:GroceryApp/sizeConfig.dart';
import 'package:GroceryApp/widgets/component/backButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CartScreen extends StatefulWidget {
  static String routeName = '/cart';
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  SharedPreferences _pref;
  var user;
  FlutterLocalNotificationsPlugin localNotif;

  @override
  void initState() {
    var androidInit = AndroidInitializationSettings('ic_launcher');
    var iosInit = IOSInitializationSettings();
    var initSetup = InitializationSettings(android: androidInit, iOS: iosInit);
    localNotif = new FlutterLocalNotificationsPlugin(); 
    localNotif.initialize(initSetup);

    initPref().whenComplete(() {
      setState(() {
        this.user = _pref.getString('username');
      });
    });
  }

  Future _showNotif() async {
    var androidDetail =
        AndroidNotificationDetails('ChannelID', 'Local Notif', 'Channel Desc');
    var iosDetail = IOSNotificationDetails();
    var generateDetail =
        NotificationDetails(android: androidDetail, iOS: iosDetail);
    await localNotif.show(
        0, 'Orderan Masuk', 'Ada orderan masuk nih, cek yuk', generateDetail);
  }

  Future<void> initPref() async {
    this._pref = await SharedPreferences.getInstance();
  }

  CollectionReference cart =
      FirebaseFirestore.instance.collection('cartProduct');

  int sumTotal = 0;
  int total;
  //@override
  // void initState() {
  //   final cartData = cart.snapshots();

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: getFlexibleWidth(100),
                                          height: getFlexibleHeight(125),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image(
                                                image: FileImage(File(snapshot
                                                    .data.docs[index]['img'])),
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
                                                  fontSize:
                                                      getFlexibleWidth(15),
                                                  color: Color(
                                                      hexColor('#5e6eff'))),
                                            )),
                                            Container(
                                              child: Text(
                                                '\$${snapshot.data.docs[index]['price']}',
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  IconButton(
                                                    onPressed: () {
                                                      int intQty = snapshot.data
                                                          .docs[index]['qty'];
                                                      if (intQty > 1) {
                                                        intQty--;
                                                        var ref = snapshot
                                                            .data
                                                            .docs[index]
                                                            .reference;
                                                        total = intQty *
                                                            snapshot.data
                                                                    .docs[index]
                                                                ['price'];
                                                        ref
                                                            .update({
                                                              'qty': intQty,
                                                              'total': total
                                                            })
                                                            .then((value) =>
                                                                print(
                                                                    'oke aman'))
                                                            .catchError(
                                                                (error) {
                                                              print('Error');
                                                            });
                                                      }
                                                      print(intQty);
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
                                                            color: Color(
                                                                hexColor(
                                                                    '#5e6eff')),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      // print('tambah');
                                                      int intQty = snapshot.data
                                                          .docs[index]['qty'];
                                                      intQty++;
                                                      print(intQty);
                                                      var ref = snapshot
                                                          .data
                                                          .docs[index]
                                                          .reference;
                                                      total = intQty *
                                                          snapshot.data
                                                                  .docs[index]
                                                              ['price'];
                                                      ref
                                                          .update({
                                                            'qty': intQty,
                                                            'total': total
                                                          })
                                                          .then((value) =>
                                                              print('oke aman'))
                                                          .catchError((error) {
                                                            print('Error');
                                                          });
                                                      sumTotal = intQty *
                                                          snapshot.data
                                                                  .docs[index]
                                                              ['price'];
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
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: getFlexibleWidth(20)),
                                          child: IconButton(
                                            icon: Icon(Icons.cancel),
                                            iconSize: getFlexibleWidth(30),
                                            color: Color(hexColor('#5969ff')),
                                            onPressed: () {
                                              DeleteCart.deleteCart(snapshot
                                                  .data.docs[index].reference);
                                            },
                                          ),
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
                ),
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: cart.snapshots(),
                    builder: (BuildContext ctx,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        for (var i = 0; i < snapshot.data.docs.length; i++) {
                          sumTotal = snapshot.data.docs[i]['total'];
                        }
                        return Column(
                          children: [
                            Text(
                              'Total Price : \$$sumTotal',
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Color(hexColor('#5969ff')),
                              ),
                            ),
                            SizedBox(
                              height: getFlexibleHeight(20),
                            ),
                            Container(
                              height: getFlexibleHeight(50),
                              width: getFlexibleWidth(200),
                              decoration: BoxDecoration(
                                  color: Color(hexColor('#5969ff')),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () => {
                                        _showNotif(),
                                      CheckOut().setData(user,'pending',sumTotal),
                                      Get.offNamed('/home'),
                                      },
                                      splashColor: Colors.white,
                                      child: Center(
                                        child: Text(
                                          'Buy Now',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ))),
                            ),
                          ],
                        );
                      } else {
                        return Text('Loading');
                      }
                    },
                  ),
                  width: double.infinity,
                  margin:
                      EdgeInsets.symmetric(horizontal: getFlexibleWidth(20)),
                  padding: EdgeInsets.symmetric(
                      horizontal: getFlexibleWidth(20),
                      vertical: getFlexibleHeight(20)),
                  decoration: BoxDecoration(
                      color: Color(hexColor('#bac1ff')),
                      borderRadius: BorderRadius.circular(12)),
                  //padding: EdgeInsets.all(20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
