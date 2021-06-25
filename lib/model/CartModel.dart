import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AddtoCart {
  CollectionReference cart =
      FirebaseFirestore.instance.collection('cartProduct');

  String name;
  double price;
  double total;
  int qty;

  AddtoCart({
    @required this.name,
    @required this.price,
    @required this.total,
    @required this.qty,
  });

  Future<void> addCart() {
    return cart
        .add({
          'name': name,
          'price': price,
          'total': total,
          'qty': qty,
        })
        .then((_) => print('Cart Added'))
        .catchError((_) => print('Error Bende'));
  }
}
