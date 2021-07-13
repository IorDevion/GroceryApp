import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserService {
  CollectionReference _user = FirebaseFirestore.instance.collection('user');

  Future<void> signUp(String name, String email, String pass, String role,
      String location) async {
    await _user.add({
      'name': name,
      'email': email,
      'pass': pass,
      'role': role,
      'location': location
    });
  }

  Future<void> updateUser(String location, String docRef) async {
    await _user.doc(docRef).update({'location': location});
  }
}
