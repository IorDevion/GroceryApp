import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteProduct{
  CollectionReference favProduct = FirebaseFirestore.instance.collection('favProduct');
  
  Future<void> addtoFav(String name,String user, int price){
    favProduct.add({
      'nameProduct' : name,
      'user' : user,
      'price' : price,
    });
  }

  static Future<void> removeFav(docRef) async {
    return await FirebaseFirestore.instance.runTransaction((transaction) {
      transaction.delete(docRef);
    });
  }

}