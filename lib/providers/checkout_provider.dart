import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_vegetable/model/delivery_address_model.dart';

class CheckoutProvider with ChangeNotifier {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController area = TextEditingController();

  void validator() async {
    await FirebaseFirestore.instance
        .collection('AddDeliveryAddress')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set({
      'FirstName': firstName.text,
      'LastName': lastName.text,
      'Mobile': mobile.text,
      'City': city.text,
      'Area': city.text,
    });
    notifyListeners();
  }

  List<DeliveryAddressModel> deliveryAddressData = [];
  getDeliveryAddress() async {
    List<DeliveryAddressModel> newList = [];

    DocumentSnapshot qn = await FirebaseFirestore.instance
        .collection('AddDeliveryAddress')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();

    if (qn.exists) {
      // print(qn.data());
      DeliveryAddressModel deliveryAddressModel = DeliveryAddressModel(
        firstName: qn.get('FirstName'),
        lastName: qn.get('LastName'),
        mobile: qn.get('Mobile'),
        city: qn.get('City'),
        area: qn.get('Area'),
      );
      newList.add(deliveryAddressModel);
    }
    deliveryAddressData = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressData {
    return deliveryAddressData;
  }
}
