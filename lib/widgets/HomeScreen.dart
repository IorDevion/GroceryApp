import 'package:GroceryApp/color.dart';
import 'package:GroceryApp/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import './component/backButton.dart';
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ButtonList(),
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
                        return ProductCard(
                            product: new ProductItem(
                          name: product['name'],
                          price: product['price'],
                          desc: product['desc'],
                          img: product['img'],
                          id: product['id'],
                        ));
                      },
                    );
                  } else {
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
