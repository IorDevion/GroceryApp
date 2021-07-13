import 'dart:io';

import 'package:GroceryApp/color.dart';
import 'package:GroceryApp/model/auth_Service.dart';
import 'package:GroceryApp/model/productItem.dart';
import 'package:GroceryApp/sizeConfig.dart';
import 'package:GroceryApp/widgets/component/default_button.dart';
import 'package:GroceryApp/widgets/icons/my_flutter_app_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminScreen extends StatefulWidget {
  
  static String routeName = '/admin';
  const AdminScreen({Key key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  SharedPreferences _pref;

  @override
  void initState() {
    initPref().whenComplete((){
      setState(() {});
    });
    super.initState();
  }
  Future<void> initPref() async{
    this._pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
  SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(hexColor('#6C63FF')),
            title: Text(
              'Admin Page',
              style: GoogleFonts.montserrat(
                  fontSize: 15, color: Color(hexColor('#ffffff'))),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  //
                },
              ),
              IconButton(
                icon: Icon(MyFlutterApp.logout),
                onPressed: () async {
                  await AuthService.signOut();      
                  _pref.remove('splash');            
                  Get.offNamed('/login');
                },
              ),
            ],
          ),
          body: AdminContent(),
          bottomNavigationBar: BottomBar(),
        ),
      ),
    );
  }
}

class AdminContent extends StatefulWidget {
  const AdminContent({Key key}) : super(key: key);

  @override
  _AdminContentState createState() => _AdminContentState();
}

class _AdminContentState extends State<AdminContent> {
  CollectionReference itemProduct =
      FirebaseFirestore.instance.collection('productItem');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: itemProduct.snapshots(),
            builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext ctx, index) {
                    //print(snapshot.data.docs[index]['name']);
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: getFlexibleWidth(10),
                          vertical: getFlexibleHeight(10)),
                      padding: EdgeInsets.symmetric(
                          horizontal: getFlexibleWidth(15),
                          vertical: getFlexibleHeight(10)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(hexColor('#bac1ff')),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: getFlexibleHeight(10),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                width: getFlexibleWidth(100),
                                height: getFlexibleHeight(125),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: FileImage( File(snapshot.data.docs[index]['img'])),
                                    fit: BoxFit.fill, 
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getFlexibleHeight(10),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: getFlexibleWidth(5),
                                      vertical: getFlexibleHeight(15)),
                                  child: Text(
                                    "Name : ${snapshot.data.docs[index]['name']}",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        color: Color(hexColor('#5e6eff'))),
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: getFlexibleHeight(15)),
                                child: Text(
                                  "Price : \$${snapshot.data.docs[index]['price']}",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(hexColor('#5e6eff'))),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Quantity : ${snapshot.data.docs[index]['stock']}",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(hexColor('#5e6eff'))),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                child: IconButton(
                                  color: Color(hexColor('#5e6eff')),
                                  icon: Icon(Icons.edit),
                                  iconSize: 20,
                                  onPressed: () {
                                    print('Edit Item');
                                    //
                                  },
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  color: Color(hexColor('#5e6eff')),
                                icon: Icon(MyFlutterApp.cancel),
                                  iconSize: 20,
                                  onPressed: () {
                                    ProductItem.deleteItem(
                                        snapshot.data.docs[index].reference);
                                    //
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
              } else {
                return Text('Loading');
              }
              // (snapshot.hasData) ?
              // return ListView.builder(itemBuilder: )
              // :
              // return Text('Loading');
            },
          ),
        ),
      ),
    ));
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getFlexibleWidth(20), vertical: getFlexibleHeight(10)),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, -3),
            spreadRadius: 2,
            blurRadius: 6)
      ]),
      child: GestureDetector(
        child: DefaultButton(text: 'Add new product'),
        onTap: () {
          Get.toNamed('/addProduct');
        },
      ),
    );
  }
}
