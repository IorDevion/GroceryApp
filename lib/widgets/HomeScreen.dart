import 'package:GroceryApp/color.dart';
import 'package:GroceryApp/widgets/icons/my_flutter_app_icons.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/component/buttonFav.dart';
import 'package:GroceryApp/model/auth_Service.dart';
import 'package:GroceryApp/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './component/button_list.dart';
import './component/product_card.dart';

import '../model/productItem.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: HomeContent()),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
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
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productItem = firestore.collection('productItem');

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: getFlexibleHeight(30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             IconButton(
                onPressed: (){
                  Get.toNamed('/profile');
                },
                icon: Icon(Icons.account_box),
                iconSize: 37,
                color: Color(hexColor('#6C63FF')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/fav');
                    },
                    child: ButtonFav(),
                  ),
                  SizedBox(
                    width: getFlexibleWidth(20),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await AuthService.signOut();
                      Get.offNamed('/login');
                      _pref.remove('splash');            
                    },
                    child: ButtonList(),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: getFlexibleHeight(30),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getFlexibleWidth(20)),
              // child: GridView.builder(
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       childAspectRatio: 0.75,
              //       crossAxisSpacing: 10,
              //       mainAxisSpacing: 10),
              //   itemBuilder: (context, index) {
              //     return Card(
              //       child: Column(
              //         children: <Widget>[
              //           Container(
              //               height: getFlexibleHeight(200),
              //               width: double.infinity,
              //               child: StreamBuilder<QuerySnapshot>(
              //                 stream: productItem.snapshots(),
              //                 builder: (BuildContext context,
              //                     AsyncSnapshot<QuerySnapshot> snapshot) {
              //                   if (snapshot.hasData) {
              //                     return Column(
              //                       children: snapshot.data.docs
              //                       .map((e) => Text(e.get('name')))
              //                       .toList()
              //                     );
              //                   }else{
              //                       return Text('Loading');
              //                   }
              //                   // if(!snapshot.hasData){
              //                   //   return Text('No product item');
              //                   // }else{
              //                   //   return Container(
              //                   //     child: Text(snapshot.data.docs.map((e) => e['name'])),
              //                   //     //child : snapshot.data.docs.map((e) => Text(e['name'].toString()))
              //                   //   );
              //                   // }
              //                 },
              //               )
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              //   itemCount: cardData.length,
              // ),
              child: StreamBuilder<QuerySnapshot>(
                stream: productItem.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    // return Column(
                    //     children: snapshot.data.docs
                    //         .map((e) => Text(e.get('name')))
                    //         .toList());
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext ctx, index) {
                        // print(snapshot.data.docs[index]['name']);
                        var product = snapshot.data.docs[index];
                        var prodId = product.reference.path;
                        var splitId = prodId.split('/').last;
                        return ProductCard(
                            product: new ProductItem(
                          name: product['name'],
                          price: product['price'],
                          desc: product['desc'],
                          img: product['img'],
                          id: splitId,
                        ));
                      },
                    );
                  }  else {
                    return Text('Loading...');
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
