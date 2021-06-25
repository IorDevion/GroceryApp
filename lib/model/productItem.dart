import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductItem {
  String id;
  String name;
  double price;
  String desc;
  String img;

  ProductItem({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.desc,
    @required this.img,
  });
}


// class ProductItemServices{
//   static CollectionReference productItem = FirebaseFirestore.instance.collection('productItem');
  
//   static Future<void> createOrUpdate(String id,{String name, int price,String desc}) async {
//     await productItem.doc('1').set({
//       'name' : name,
//       'price' : price,
//       'desc' : desc,
//     });
//   } 
//   // static Future<DocumentSnapshot> getProduct(String id) async{
//   //   return 
//   // }
// }