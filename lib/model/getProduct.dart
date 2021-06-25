import 'package:cloud_firestore/cloud_firestore.dart';
class Product {
  static CollectionReference productCollection = FirebaseFirestore.instance.collection('productItem');

  static Future<DocumentSnapshot> getProduct(String id) async{
      return await productCollection.doc(id).get();
  }
}