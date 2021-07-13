import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AddtoCart {
  CollectionReference cart =
      FirebaseFirestore.instance.collection('cartProduct');

  String name;
  int price;
  int total;
  String img;
  int qty;

  AddtoCart({
    @required this.name,
    @required this.price,
    @required this.total,
    @required this.qty,
    @required this.img,
  });

  Future<void> addCart() {
    return cart
        .add({
          'name': name,
          'price': price,
          'total': total,
          'qty': qty,
          'img':img,
        })
        .then((_) => print('Cart Added'))
        .catchError((_) => print('Error Bende'));
  }
}
