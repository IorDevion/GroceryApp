import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckOut{
  CollectionReference checkOut = FirebaseFirestore.instance.collection('checkOut');

  Future<void> setData(String name,String status, int totalPrice) async {
    await checkOut.add({
      'name':name,
      'status':status,
      'totalPrice':totalPrice,
    });
  }
}