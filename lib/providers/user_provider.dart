import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  void addUser(
    User currentuser,
    String userName,
    String userEmail,
    String userImage,
    String userId,
  ) {
    FirebaseFirestore.instance.collection('UserData').doc(currentuser.uid).set({
      'userName': userName,
      'userEmail': userEmail,
      'userImage': userImage,
      'userId': currentuser.uid,
    });
  }
}
