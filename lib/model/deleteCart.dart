import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteCart {
  
  CollectionReference cartProduct = FirebaseFirestore.instance.collection('cartProduct');
  // static Future<void> deleteCart(String id) async{
  //   return cartProduct
  //       .doc(id.toString())
  //       .delete()
  //       .then((value) => print('User Deleted'))
  //       .catchError((error) => print('Failed to delete'));
  // }
  static Future<void> deleteCart(docReference) async{
    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.delete(docReference);
    });
  }
}
