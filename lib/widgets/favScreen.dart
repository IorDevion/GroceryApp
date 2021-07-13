import 'package:GroceryApp/color.dart';
import 'package:GroceryApp/model/favModel.dart';
import 'package:GroceryApp/sizeConfig.dart';
import 'package:GroceryApp/widgets/component/backButton.dart';
import 'package:GroceryApp/widgets/icons/my_flutter_app_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FavScreen extends StatelessWidget {
  static String routeName = '/fav';
  const FavScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: FavContent(),
        ),
      ),
    );
  }
}

class FavContent extends StatefulWidget {

  @override
  _FavContentState createState() => _FavContentState();
}

class _FavContentState extends State<FavContent> {

  CollectionReference favItem = FirebaseFirestore.instance.collection('favProduct');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: getFlexibleHeight(20),
          ),
          Row(
            children: [
              GestureDetector(
                child: PrevButton(),
                onTap: (){
                  Get.back();
                },
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text('Favorite Product',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Color(hexColor('#5e6eff'))
                ),),
              ),
            ],
          ),
          SizedBox(
            height: getFlexibleHeight(20),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: StreamBuilder<QuerySnapshot>(
              stream: favItem.snapshots(),
              builder:(BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: getFlexibleWidth(20),vertical: getFlexibleHeight(20)),  
                      decoration: BoxDecoration(
                        color: Color(hexColor('#bac1ff')),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Text(snapshot.data.docs[index]['nameProduct'],style: GoogleFonts.montserrat(fontSize: 20,color:Color(hexColor('#5e6eff'))),),
                              Container(
                                child: IconButton(
                                  color: Color(hexColor('#5e6eff')),
                                  icon: Icon(MyFlutterApp.cancel),
                                  iconSize: 20,   
                                  onPressed: () {
                                    FavoriteProduct.removeFav(
                                        snapshot.data.docs[index].reference);
                                    //
                                  },
                                ),
                              ),
                            ],
                          ),
                          Text('\$${snapshot.data.docs[index]['price']}',style: GoogleFonts.montserrat(fontSize: 20,color:Color(hexColor('#5e6eff'))),),
                        ],
                      ),
                    );
                  },
                  itemCount: snapshot.data.docs.length,
                );
                }else{
                  return Center(child: Text('Loading'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}