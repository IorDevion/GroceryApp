import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductItem {

  CollectionReference productItem = FirebaseFirestore.instance.collection('productItem');
  
  String id;
  String name;
  int price;
  String desc;
  String img;

  ProductItem({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.desc,
    @required this.img,
  });

  static Future<void> deleteItem(docReference) async {
    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.delete(docReference);
    });
  }
  
  Future<void> addnewProduct(String name,String desc, int price, String img,int stock,int id) async {
    return await productItem.add({
      'name' : name,
      'desc' : desc,
      'price' : price,
      'img' : img,
      'stock' : stock,
      'id':id
    });
  }
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